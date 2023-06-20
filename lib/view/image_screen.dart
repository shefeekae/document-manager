import 'dart:io';
import 'package:document_manager_app/model/file_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

//This is the image viewing screen

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.file});

  final FileModel file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text(
          file.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Hero(
          transitionOnUserGestures: true,
          tag: file,
          child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.grey[200]),
              imageProvider: FileImage(File(file.path)))),
    );
  }
}
