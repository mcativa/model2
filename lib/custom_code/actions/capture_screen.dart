// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// Begin custom action code
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

Future<bool> captureScreen() async {
  // Add your function code here!

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  screenshotController
      .captureFromWidget(
          Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 5.0),
                color: Colors.redAccent,
              ),
              child: Text("This is an invisible widget")),
          delay: Duration(seconds: 5))
      .then((capturedImage) {
    // Handle captured image
    final result = ImageGallerySaver.saveImage(
        Uint8List.fromList(capturedImage),
        quality: 60,
        name: "hello");
    print(result);
    return true;
  });
}
