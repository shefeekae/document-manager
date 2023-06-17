import 'dart:io';
import 'dart:math' as math;

import 'package:document_manager_app/widgets/view_file.dart';
import 'package:open_file/open_file.dart';

class FileManager {
  static const int base = 1024;
  static const List<String> suffix = ['B', 'KB', 'MB', 'GB', 'TB'];
  static const List<int> powBase = [
    1,
    1024,
    1048576,
    1073741824,
    1099511627776
  ];

  // Format bytes to human readable string.
  static String formatBytes(int bytes, [int precision = 2]) {
    final base = (bytes == 0) ? 0 : (math.log(bytes) / math.log(1024)).floor();
    final size = bytes / powBase[base];
    final formattedSize = size.toStringAsFixed(precision);
    return '$formattedSize ${suffix[base]}';
  }

  // check weather FileSystemEntity is File
  // return true if FileSystemEntity is File else returns false
  static bool isFile(FileSystemEntity entity) {
    return (entity is File);
  }

//Fetch documents from device storage (png,jpeg,jpg,pdf).
  static List<FileSystemEntity> fetchFiles() {
    Directory directory = Directory('/storage/emulated/0');

    List<FileSystemEntity> folderList = directory.listSync();
    List<FileSystemEntity> fileList = [];

    for (final entity in folderList) {
      if (entity.path != '/storage/emulated/0/Android') {
        final temporaryDirectory = Directory(entity.path);
        fileList = [...fileList + temporaryDirectory.listSync(recursive: true)];
      }
    }

    List<FileSystemEntity> files = filterFiles(fileList);
    List<FileSystemEntity> finalList = [];

    files
        .map((file) => file.path.endsWith('pdf') ? finalList.add(file) : null)
        .toList();

    files
        .map((file) => file.path.endsWith('png') ? finalList.add(file) : null)
        .toList();

    files
        .map((file) => file.path.endsWith('jpeg') ? finalList.add(file) : null)
        .toList();

    files
        .map((file) => file.path.endsWith('jpg') ? finalList.add(file) : null)
        .toList();

    files
        .map((file) => file.path.endsWith('xlsx') ? finalList.add(file) : null)
        .toList();

    return finalList;
  }

  //Filter files and directories
  static List<FileSystemEntity> filterFiles(List<FileSystemEntity> fileList) {
    List<File> files = [];
    for (final entity in fileList) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  static Future<String> getSize(String path) async {
    FileStat stat = await FileStat.stat(path);
    double size = stat.size.toDouble();
    List<String> sizeNotations = ['B', 'KB', 'GB', 'TB'];
    int i = 0;
    while (size > 1024) {
      size = size / 1024;
      i++;
    }
    return "${size.toString()} ${sizeNotations[i]}";
  }
}
