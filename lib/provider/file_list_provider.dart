import 'dart:io';

import 'package:document_manager_app/controller/file_controller.dart';
import 'package:flutter/material.dart';
import '../model/file_model.dart';

class FileProvider extends ChangeNotifier {
  List<FileModel> files = [];
  List<FileModel> foundFiles = [];

//This method updates the home screen file list
  addToList(File file) {
    final newFile = FileModel(
        title: file.path.split('/').last.split('.').first,
        path: file.path,
        size: FileController.getDocumentSize(file.path),
        documentType: FileController.getDocumentSize(file.path),
        modifiedDate: FileController.getModifiedDate(file.path));

    files.add(newFile);
    notifyListeners();
  }

  setFoundFile(List<FileModel> files) {
    foundFiles = files;
    notifyListeners();
  }
}
