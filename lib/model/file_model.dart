import 'package:hive_flutter/hive_flutter.dart';

part 'file_model.g.dart';

@HiveType(typeId: 0)
class FileModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String path;

  @HiveField(3)
  String size;

  @HiveField(4)
  String documentType;

  @HiveField(5)
  String modifiedDate;

  FileModel({
    required this.title,
    required this.description,
    required this.path,
    required this.size,
    required this.documentType,
    required this.modifiedDate,
  });
}
