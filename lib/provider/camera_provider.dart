import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/view/snap_view.dart';

class CameraProvider {
  void getImage(BuildContext context, Challenge challenge) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SnapPage(image, challenge)),
    );
  }
}
