import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static generatePdf(String title, String description, File file) async {
    final pdf = Document();

    final image = await file.readAsBytes();

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        Header(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
            decoration: const BoxDecoration(color: PdfColors.red)),
        Paragraph(text: description),
        Image(MemoryImage(image))
      ],
    ));

    return saveDocument(name: title, pdf: pdf);
  }

  static saveDocument({required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    // final appDirectory = await getApplicationDocumentsDirectory();

    Directory directory = Directory('/storage/emulated/0');

    String documentsFolderPath = '${directory.path}/Files';

    await Directory(documentsFolderPath).create(recursive: true);

    final file = File('$documentsFolderPath/$name.pdf');

    await file.writeAsBytes(bytes);

    return file;
  }
}
