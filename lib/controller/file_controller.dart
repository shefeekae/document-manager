import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FileController {
  //This method fetches a list of files and set it to File Model
  List<FileModel> fetchFile(BuildContext context) {
    List<FileModel> files = FileManager.fetchFiles().map((file) {
      return FileModel(
        title: file.path.split('/').last.split('.').first,
        path: file.path,
        size: getDocumentSize(file.path),
        documentType: getDocumentType(file.path),
        modifiedDate: getModifiedDate(file.path),
      );
    }).toList();

    Provider.of<FileProvider>(context).files = files;

    return files;
  }

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
    String sizeInBytes = FileManager.formatBytes(size);
    return sizeInBytes;
  }

  //Method for getting document type
  static String getDocumentType(String path) {
    return path.split('.').last;
  }
}
