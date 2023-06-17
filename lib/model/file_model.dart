// ignore_for_file: public_member_api_docs, sort_constructors_first
class FileModel {
  FileModel({
    required this.title,
    required this.path,
    required this.size,
    required this.documentType,
    required this.modifiedDate,
    required this.description,
  });

  String title;
  String path;
  String size;
  String documentType;
  String modifiedDate;
  String description;
}
