import 'dart:io';
import 'dart:math' as math;

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
  static bool isFile(String path) {
    return (path is File);
  }

//Fetch documents from device storage (png,jpeg,jpg,pdf).
  static List<FileSystemEntity> fetchFiles() {
    Directory directory = Directory('/storage/emulated/0');
    // Directory androidDirectory = Directory('/storage/emulated/0/Android/media');

    // List<FileSystemEntity> androidMedia = androidDirectory.listSync();
    List<FileSystemEntity> folderList = directory.listSync();
    List<FileSystemEntity> fileList = [];

    // fileList.add(androidMedia);

    for (final entity in folderList) {
      if (entity.path != '/storage/emulated/0/Android') {
        final temporaryDirectory = Directory(entity.path);
        fileList = [...fileList + temporaryDirectory.listSync(recursive: true)];
      }
    }

    List<String> extensions = ['png', 'jpeg', 'jpg', 'pdf', 'xlsx'];
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
}
