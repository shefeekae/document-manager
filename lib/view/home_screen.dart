import 'dart:io';
import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/view/image_screen.dart';

import 'package:document_manager_app/view/pdf_screen.dart';
import 'package:document_manager_app/widgets/subtitle.dart';
import 'package:document_manager_app/widgets/title.dart';
import 'package:document_manager_app/widgets/view_file.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FileSystemEntity> fileList = [];

  //request permission method
  requestPermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();

      setState(() {});
    }
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void openPdfViewer(BuildContext context, File file) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PdfViewer(file: file),
    ));
  }

  void openImageViewer(BuildContext context, File file) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ImageViewer(file: file),
    ));
  }

  void _openFile(File file) {
    if (file.path.endsWith('pdf')) {
      openPdfViewer(context, file);
    } else if (file.path.endsWith('png')) {
      openImageViewer(context, file);
    } else if (file.path.endsWith('jpg')) {
      openImageViewer(context, file);
    } else if (file.path.endsWith('jpeg')) {
      openImageViewer(context, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    fileList = FileManager.fetchFiles();
    return Scaffold(
      body: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          FileSystemEntity entity = fileList[index];

          return Card(
            child: ListTile(
                leading: FileManager.isFile(entity)
                    ? const Icon(Icons.feed_outlined)
                    : const Icon(Icons.folder),
                title: Text(title(entity)),
                subtitle: subtitle(entity),
                onTap: () => _openFile(File(entity.path))),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => AddScreen(),
          // ));
        },
      ),
    );
  }
}
