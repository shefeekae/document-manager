import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Validate extends ChangeNotifier {
  String chooseFile = "";

  bool isFileValid = true;

// Vailidation method for choose file field
  checkFile(PlatformFile? pickedFile) {
    if (pickedFile == null) {
      chooseFile = "Please choose a file";
      isFileValid = false;
      notifyListeners();
    } else {
      isFileValid = true;
    }
  }
}
