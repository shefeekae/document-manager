String title(String path, {bool showFileExtension = true}) {
  final fileName = path.split('/').last;

  if (showFileExtension) return fileName;

  return showFileExtension ? fileName.split('.').first : fileName;

  // for (int i = 0; i < fileList.length; i++) {
  //   String title = fileList[i].path.split('/').last;
  //   print(title);
  // }
}
