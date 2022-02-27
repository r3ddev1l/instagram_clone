import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user_model.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snapshot);
  }

  ///Sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = "Some error occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        debugPrint("UserID::::: ${credential.user!.uid}");
        String photoUrl = await StorageMethods().uploadImageToStorage(
          childName: 'profilePics',
          file: file,
          isPost: false,
        );

        //add user to the database

        model.User user = model.User(
          email: email,
          uid: credential.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );
        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
            );

        result = "Success";
      }
    } catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    }

    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        result = "Success";
      } else {
        result = "Please enter all the fields";
      }
    } catch (e) {
      debugPrint(e.toString());
      result = e.toString();
    }
    return result;
  }
}
