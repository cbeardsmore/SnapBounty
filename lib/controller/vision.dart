import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

Future<Map<String, double>> getLabels(File image) async {
  if (image == null) {
    return null;
  }

  final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
  final ImageLabeler imageLabeler = FirebaseVision.instance.imageLabeler();

  List<ImageLabel> labelsList = await imageLabeler.processImage(visionImage);
  Map<String, double> labelsMap = new Map.fromIterable(labelsList,
      key: (v) => v.text, value: (v) => v.confidence);
  return labelsMap;
}
