import 'dart:io';
import 'dart:typed_data';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../model/file_model.dart';

class FileManager {
  Box<FileModel> fileBox = Hive.box<FileModel>('fileBox');

//Add file to the database
  addFile({required FileModel file, required BuildContext context}) async {
    final provider = Provider.of<FileProvider>(context, listen: false);

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await fileBox.add(file);

    provider.addFile(file);

    //Save document to device storage
    saveDocument(
      name: file.title,
      path: file.path,
    );
    scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.grey[200],
        content: const Text(
          "Document created successfully",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        )));
  }

//Fetch all files from database
  List<FileModel> getAllFiles({required BuildContext context}) {
    final fileDb = Hive.box<FileModel>('fileBox');

    List<FileModel> files = Provider.of<FileProvider>(context, listen: false)
        .getAllFiles(fileDb.values);

    return files;
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

    //Filter out the Android directory as we have no access to that directory
    for (final entity in folderList) {
      if (entity.path != '/storage/emulated/0/Android' &&
          !entity.path.contains('/.') &&
          entity is! File) {
        final temporaryDirectory = Directory(entity.path);
        fileList = [...fileList + temporaryDirectory.listSync(recursive: true)];
      } else if (entity.path != '/storage/emulated/0/Android' &&
          !entity.path.contains('/.') &&
          entity is File) {
        fileList.add(entity);
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

  //This method saves the document to device storage.
  static saveDocument({
    required String name,
    required String path,
  }) async {
    Uint8List bytes = File(path).readAsBytesSync();

    //Fetches all directories for device storage.
    Directory directory = Directory('/storage/emulated/0');

    //Set a folder path where the file is to be saved.
    String documentsFolderPath = '${directory.path}/FileCraft';

    //Creates the folder
    await Directory(documentsFolderPath).create(recursive: true);

    //Set the file path of the file to be saved
    final file = File('$documentsFolderPath/$name.pdf');

    //Save the file
    await file.writeAsBytes(bytes);
  }
}
