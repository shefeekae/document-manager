import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'dart:io';

class FileController {
  Future<List<FileModel>> fetchFile() async {
    List<FileModel> files = FileManager.fetchFiles().map((file) {
      return FileModel(
          title: file.path.split('/').last,
          path: file.path,
          size: getDocumentSize(file.path),
          documentType: getDocumentType(file.path),
          modifiedDate: File(file.path).lastModifiedSync().toString(),
          description: 'Some description');
    }).toList();

    return files;
  }

  getDocumentSize(String path) {
    int size = File(path).lengthSync();

    String sizeInBytes = FileManager.formatBytes(size);

    return sizeInBytes;
  }

  String getDocumentType(String path) {
    return path.split('.').last;
  }
}
