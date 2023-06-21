import 'dart:io';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class PdfApi {
  //This is the method for generating the pdf file
  static generatePdf(BuildContext context, String title, String description,
      FileModel doc) async {
    final pdf = pw.Document();
    //initialise provider
    var fileProvider = Provider.of<FileProvider>(context, listen: false);

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final file = File(doc.path);
    final image = await file.readAsBytes();

    const pageTheme = pw.PageTheme(pageFormat: PdfPageFormat.a4);

    //This method creates a pdf page.
    pdf.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      build: (context) => <pw.Widget>[
        pw.Container(
          padding: const pw.EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
          decoration: const pw.BoxDecoration(
              border: pw.Border(
                  bottom: pw.BorderSide(width: 2, color: PdfColors.blue))),
          child: pw.Row(children: [
            pw.PdfLogo(),
            pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
            pw.Text('Pdf Document',
                style: const pw.TextStyle(fontSize: 20, color: PdfColors.blue))
          ]),
        ),

        pw.Header(child: pw.Text(" Attached file details")),
        pw.Bullet(text: ("File name : ${doc.title}")),
        pw.Bullet(text: ("Date created : ${doc.modifiedDate}")),
        //Shows entered title
        pw.Header(
            child: pw.Text(
              title,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 26,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
            decoration: const pw.BoxDecoration(color: PdfColors.red)),
        pw.Header(child: pw.Text("Description")),

        //Shows entered description
        pw.Paragraph(text: description),

        pw.Paragraph(text: pw.LoremText().paragraph(60)),

        //Shows fetched image
        pw.SizedBox(
          height: 600,
          child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.fill),
        ),
      ],
      footer: (context) {
        final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

        return pw.Container(
            margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            alignment: pw.Alignment.centerRight,
            child: pw.Text(text));
      },
    ));

    return saveDocument(
        fileProvider: fileProvider,
        name: title,
        pdf: pdf,
        scaffoldMessenger: scaffoldMessenger);
  }

  //This method saves the document to device storage.
  static saveDocument(
      {required FileProvider fileProvider,
      required String name,
      required ScaffoldMessengerState scaffoldMessenger,
      required pw.Document pdf}) async {
    final bytes = await pdf.save();

    //Fetches all directories for device storage.
    Directory directory = Directory('/storage/emulated/0');

    //Set a folder path where the file is to be saved.
    String documentsFolderPath = '${directory.path}/FileCraft';

    //Creates the folder
    await Directory(documentsFolderPath).create(recursive: true);

    //Set the file path of the file to be saved
    final file = File('$documentsFolderPath/$name.pdf');

    //Save the file
    await file.writeAsBytes(bytes);

    //Calling this method will update the home screen file list.
    fileProvider.addToList(file);

    scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Colors.grey[200],
        content: const Text(
          "Document created successfully",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        )));

    return file;
  }

  static Future openFile(String filePath) async {
    await OpenFile.open(filePath);
  }
}
