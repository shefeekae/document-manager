import 'package:document_manager_app/model/file_model.dart';
import 'package:flutter/material.dart';

class Validate extends ChangeNotifier {
  String chooseFile = "";

  bool isFileValid = true;

// Vailidation method for choose file field
  checkFile(FileModel? pickedFile) {
    if (pickedFile == null) {
      chooseFile = "Please choose a file";
      notifyListeners();
      isFileValid = false;
      notifyListeners();
    } else {
      isFileValid = true;
    }
  }
}
