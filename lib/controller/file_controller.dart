import 'package:document_manager_app/functions/file_manager.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math' as math;
import '../constants/constants.dart';
import '../model/file_model.dart';

class FileController {
  FileManager fileManager = FileManager();

  //This method fetches a list of files and set it to File Model
  // List<FileModel> fetchFile() {
  //   List<FileModel> fetchedFiles = [];

  //   List files = FileManager.fetchFiles();

  //   fetchedFiles = files.map((file) {
  //     return FileModel(
  //       title: file.path.split('/').last.split('.').first,
  //       path: file.path,
  //       size: getDocumentSize(file.path),
  //       documentType: getDocumentType(file.path),
  //       modifiedDate: getModifiedDate(file.path),
  //     );
  //   }).toList();

  //   return fetchedFiles;
  // }

//Method for getting modified date
  static getModifiedDate(String path) {
    return File(path)
        .lastModifiedSync()
        .toString()
        .split('.')
        .first
        .split(' ')
        .first;
  }

  //Method for getting document size
  static getDocumentSize(String path) {
    int size = File(path).lengthSync();
    String sizeInBytes = formatBytes(size);
    return sizeInBytes;
  }

  //Method for getting document type
  static String getDocumentType(String path) {
    return path.split('.').last;
  }

  // Format bytes to human readable string.
  static String formatBytes(int bytes, [int precision = 2]) {
    final base = (bytes == 0) ? 0 : (math.log(bytes) / math.log(1024)).floor();
    final size = bytes / powBase[base];
    final formattedSize = size.toStringAsFixed(precision);
    return '$formattedSize ${suffix[base]}';
  }

  //Fetches all files from database
  List<FileModel> getAllFiles(BuildContext context) {
    List<FileModel> files = fileManager.getAllFiles(context: context);

    return files;
  }

  //Add file to the database
  addFile(
      {required GlobalKey<FormState> formKey,
      required BuildContext context,
      required String title,
      required String description,
      required String path}) {
    FileModel file = FileModel(
      title: title,
      description: description,
      path: path,
      size: getDocumentSize(path),
      documentType: getDocumentType(path),
      modifiedDate: getModifiedDate(path),
    );

    fileManager.addFile(file: file, context: context);
  }
}
