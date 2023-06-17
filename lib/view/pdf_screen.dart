import 'dart:io';
import 'package:document_manager_app/widgets/title.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.file});

  final File file;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = title(widget.file);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      // body: PDFView(

      //   filePath: file.path,
      //   enableSwipe: true,
      // ),

      body: SfPdfViewer.file(
        widget.file,
        controller: _pdfViewerController,
      ),
    );
  }
}
