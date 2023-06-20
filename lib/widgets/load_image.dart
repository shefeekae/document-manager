import 'dart:io';
import 'package:flutter/material.dart';

Widget loadImage(String path) {
  try {
    final file = File(path);
    final image = Image.file(
      file,
      fit: BoxFit.cover,
    );
    return image;
  } catch (e) {
    return Image.asset(
      "assets/unsupported image.png",
      fit: BoxFit.cover,
    );
  }
}
