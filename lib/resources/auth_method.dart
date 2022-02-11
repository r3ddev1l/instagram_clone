import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Sign up

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = "Some error occured";

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
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        result = "Success";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }
}
