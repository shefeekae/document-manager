import 'dart:io';
import 'package:document_manager_app/functions/file_manager.dart';
import 'package:flutter/material.dart';

Widget subtitle(FileSystemEntity entity) {
  return FutureBuilder<FileStat>(
    future: entity.stat(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (entity is File) {
          int size = snapshot.data!.size;

          return Text(
            FileManager.formatBytes(size),
          );
        }
        return Text(
          "${snapshot.data!.modified}".substring(0, 10),
        );
      } else {
        return const Text("");
      }
    },
  );
}
