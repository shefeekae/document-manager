import 'package:flutter/material.dart';

import '../model/file_model.dart';

class FileProvider extends ChangeNotifier {
  List<FileModel> files = [];
  List<FileModel> foundFiles = [];

//Add files to the database
  addFile(FileModel file) {
    files.add(file);
    notifyListeners();
  }

  List<FileModel> getAllFiles(Iterable<FileModel> allFiles) {
    files.clear();
    files.addAll(allFiles);
    // notifyListeners();

    return files;
  }

  setFoundFile(List<FileModel> files) {
    foundFiles = files;
    notifyListeners();
  }
}
