// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// Begin custom action code
import 'package:screenshot/screenshot.dart';

Future<List<int>> captureScreen() async {
  // Add your function code here!
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  screenshotController
      .captureFromWidget(Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 5.0),
            color: Colors.redAccent,
          ),
          child: Text("This is an invisible widget")))
      .then((capturedImage) {
    // Handle captured image
    return capturedImage;
  });
}
