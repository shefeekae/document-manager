import 'dart:io';
import 'dart:math' as math;
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class FileManager {
  // Format bytes to human readable string.
  static String formatBytes(int bytes, [int precision = 2]) {
    final base = (bytes == 0) ? 0 : (math.log(bytes) / math.log(1024)).floor();
    final size = bytes / powBase[base];
    final formattedSize = size.toStringAsFixed(precision);
    return '$formattedSize ${suffix[base]}';
  }

//This method checks whether the file is a pdf or not
  static bool isPdf(String documentType) {
    if (documentType == 'pdf') {
      return true;
    } else {
      return false;
    }
  }

//This method checks whether the file is excel sheet file or not
  static bool isXlsx(String documentType) {
    if (documentType == 'xlsx') {
      return true;
    } else {
      return false;
    }
  }

  //Method for searching files
  static void searchFile(
      BuildContext context, String enteredKetword, List<FileModel> allFiles) {
    List<FileModel> results = [];

    results = allFiles
        .where((FileModel file) =>
            file.title.toLowerCase().startsWith(enteredKetword.toLowerCase()))
        .toList();

    Provider.of<FileProvider>(context, listen: false).setFoundFile(results);
  }

//Fetch documents from device storage (png,jpeg,jpg,pdf).
  static List<FileSystemEntity> fetchFiles() {
    //Fetches all directories from device storage
    Directory directory = Directory('/storage/emulated/0');
    List<FileSystemEntity> folderList = directory.listSync();

    List<FileSystemEntity> fileList = [];

    //Files in the android-media folder
    // List<FileSystemEntity> tempList = [
    //   Directory('/storage/emulated/0/Android/media')
    // ];

    // folderList = [...folderList + tempList];

    //Filter out the Android directory as we have no access to that directory
    for (final entity in folderList) {
      if (entity.path != '/storage/emulated/0/Android' &&
          !entity.path.contains('/.')) {
        final temporaryDirectory = Directory(entity.path);
        fileList = [...fileList + temporaryDirectory.listSync(recursive: true)];
      }
    }
    //Preferred extensions
    List<String> extensions = ['png', 'jpeg', 'jpg', 'pdf', 'xlsx'];

    //This list contains the files with preferred extensions
    List<FileSystemEntity> files = filterFiles(fileList, extensions);

    return files;
  }

  //This method is used to filter out only the files with required
  //extensions from the fetched files.
  static List<FileSystemEntity> filterFiles(
      List<FileSystemEntity> fileList, List<String> extensions) {
    List<File> finalList = [];
    for (final entity in fileList) {
      if (entity is File) {
        for (String extension in extensions) {
          if (entity.path.endsWith(extension)) {
            finalList.add(entity);
            break;
          }
        }
      }
    }

    return finalList;
  }

//This method filters all images fetched from the device storage
  static List<FileModel> filterImages(List<FileModel> files) {
    List<FileModel> imageList = [];

    for (final file in files) {
      switch (file.documentType) {
        case 'png':
          imageList.add(file);
          break;
        case 'jpg':
          imageList.add(file);
          break;

        case 'jpeg':
          imageList.add(file);
          break;
      }
    }
    return imageList;
  }
}
