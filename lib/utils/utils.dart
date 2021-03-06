import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage({required ImageSource imageSource}) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: imageSource);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    debugPrint('No image selected');
  }
}

showSnackBar({required String content, required BuildContext context}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
