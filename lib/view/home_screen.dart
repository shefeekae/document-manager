import 'dart:io';
import 'package:document_manager_app/controller/file_controller.dart';
import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/view/add_screen.dart';
import 'package:document_manager_app/view/image_screen.dart';
import 'package:document_manager_app/view/pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FileModel> fileList = [];

  FileController _fileController = FileController();

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

  getAllFiles() async {
    fileList = await _fileController.fetchFile();
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
    // fileList = _fileController.fetchFile();
    return Scaffold(
      body: FutureBuilder(
          future: getAllFiles(),
          builder: (context, file) {
            return ListView.builder(
              itemCount: fileList.length,
              itemBuilder: (context, index) {
                FileModel file = fileList[index];

                return Card(
                  child: ListTile(
                      leading: FileManager.isFile(file.path)
                          ? const Icon(Icons.feed_outlined)
                          : const Icon(Icons.folder),
                      title: Text(file.title),
                      subtitle: Text(file.size),
                      onTap: () => _openFile(File(file.path))),
                );
              },
            );
          }),
      floatingActionButton: Container(
        height: 50,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.green[400]),
        child: TextButton(
          child: const Text(
            "Create / Upload File",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddScreen(
                files: fileList,
              ),
            ));
          },
        ),
      ),
    );
  }
}
