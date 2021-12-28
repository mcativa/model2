// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:photo_view/photo_view.dart';

class Photoview extends StatefulWidget {
  const Photoview({
    Key key,
    this.width,
    this.height,
    this.imageProvider,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageProvider;

  @override
  _PhotoviewState createState() => _PhotoviewState();
}

class _PhotoviewState extends State<Photoview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: const NetworkImage(
        "https://source.unsplash.com/1900x3600/?camera,paper",
      ),
      //imageProvider: AssetImage("assets/large-image.jpg"),
    ));
  }
}
