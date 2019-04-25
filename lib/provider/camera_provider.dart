import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/view/snap_view.dart';

class CameraProvider {
  void getImage(BuildContext context, Challenge challenge) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SnapPage(image, challenge)),
      (Route<dynamic> route) => false,
    );
  }
}
