import 'dart:io';

import 'package:document_manager_app/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    final name = title(file.path);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(name),
      ),
      body: PhotoView(imageProvider: FileImage(file)),
    );
  }
}
