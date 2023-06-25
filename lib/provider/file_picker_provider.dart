import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerProvider extends ChangeNotifier {
  PlatformFile? pickedFile;

  bool hasPermission = true;

//show file picker
  pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpeg', 'jpg', 'pdf', 'xlsx'],
        withData: true,
      );

      if (result == null) {
        pickedFile = null;
        notifyListeners();
      } else {
        pickedFile = result.files.first;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      if (e.code == 'read_external_storage_denied') {
        checkPermission();
        if (!hasPermission) {
          grantPermission();
        }
      }
    }
  }

  // //request permission method
  checkPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status.isPermanentlyDenied) {
      hasPermission = true;
      notifyListeners();
      return true;
    } else {
      hasPermission = false;
      notifyListeners();
      return false;
    }
  }

  // //grant permssion method
  grantPermission() async {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      hasPermission = true;
      notifyListeners();
    }
  }

  refreshScreen() {
    pickedFile = null;
    notifyListeners();
  }
}
