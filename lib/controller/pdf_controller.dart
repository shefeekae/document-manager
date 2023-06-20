import 'package:document_manager_app/api/pdf_api.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/validation.dart';

class GeneratePdfController {
  //This method calls the generate pdf method
  createDocument(
    GlobalKey<FormState> formKey,
    BuildContext context,
    FileModel? pickedFile,
    String title,
    String description,
  ) {
    if (formKey.currentState!.validate()) {
      Provider.of<Validate>(context, listen: false).checkFile(pickedFile);

      if (Provider.of<Validate>(context, listen: false).isFileValid) {
        PdfApi.generatePdf(
          context,
          title,
          description,
          pickedFile!,
        );

       
      }
    }
  }
}
