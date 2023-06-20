import 'dart:io';

import 'package:document_manager_app/api/pdf_api.dart';
import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

import '../widgets/details_field.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.file});

  final FileModel file;

  static void openPdfViewer(BuildContext context, FileModel file) {
    Navigator.of(context).pushNamed('/pdfViewer', arguments: file);
  }

  openImageViewer(BuildContext context, FileModel file) {
    Navigator.of(context).pushNamed('/imageViewer', arguments: file);
  }

  openFile(FileModel file, BuildContext context) {
    if (file.path.endsWith('pdf')) {
      openPdfViewer(context, file);
    } else if (file.path.endsWith('png')) {
      openImageViewer(context, file);
    } else if (file.path.endsWith('jpg')) {
      openImageViewer(context, file);
    } else if (file.path.endsWith('jpeg')) {
      openImageViewer(context, file);
    } else if (file.documentType == 'xlsx') {
      PdfApi.openFile(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Hero(
                  tag: file,
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FileManager.isPdf(file.documentType)
                          ? Image.asset("assets/pdf-1512.png")
                          : FileManager.isXlsx(file.documentType)
                              ? Image.asset("assets/xlsx-file.png")
                              : Image.file(File(file.path)),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      DetailsField(
                        fieldName: "Name :",
                        fieldValue: file.title,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      DetailsField(
                        fieldName: "Modified date :",
                        fieldValue: file.modifiedDate,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      DetailsField(
                        fieldName: "Size :",
                        fieldValue: file.size,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      DetailsField(
                        fieldName: "Type :",
                        fieldValue: file.documentType,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyButton(
                backgroundColor: const Color.fromARGB(255, 55, 126, 94),
                title: "View file",
                onPressed: () => openFile(file, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
