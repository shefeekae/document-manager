import 'package:document_manager_app/model/file_model.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.file});

  final FileModel file;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfController pdfController;

  @override
  void initState() {
    pdfController =
        PdfController(document: PdfDocument.openFile(widget.file.path));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.file.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
