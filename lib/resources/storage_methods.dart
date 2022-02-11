import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// add image to FirebaseStorage
  Future<String> uploadImageToStorage({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    ///location to store image
    Reference reference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = reference.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    debugPrint("DownloadURL::::: $downloadUrl");
    return downloadUrl;
  }
}
