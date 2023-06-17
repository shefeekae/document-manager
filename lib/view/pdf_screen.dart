import 'dart:io';
import 'package:document_manager_app/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.file});

  final File file;

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
    final name = title(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      // body: PDFView(

      //   filePath: file.path,
      //   enableSwipe: true,
      // ),

      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
