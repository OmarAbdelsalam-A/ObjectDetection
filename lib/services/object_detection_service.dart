import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ObjectDetectionService {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('yolov8.tflite');
  }

  Future<List<Map<String, dynamic>>> detectObjects(File imageFile) async {
    if (_interpreter == null) {
      throw Exception("Model not loaded");
    }

    final image = img.decodeImage(imageFile.readAsBytesSync());
    final resizedImage = img.copyResize(image!, width: 640, height: 640);
    final input = List.generate(
        1, (_) => resizedImage.getBytes().map((byte) => byte / 255.0).toList());

    final output = List.filled(1 * 25200 * 85, 0.0).reshape([1, 25200, 85]);
    _interpreter!.run(input, output);

    final results = <Map<String, dynamic>>[];
    for (int i = 0; i < output[0].length; i++) {
      final confidence = output[0][i][4];
      if (confidence > 0.5) {
        results.add({
          'confidence': confidence,
          'bbox': output[0][i].sublist(0, 4),
          'class': output[0][i].sublist(5).indexWhere((val) => val > 0.5),
        });
      }
    }
    return results;
  }
}
