import 'dart:io';

import 'package:document_manager_app/api/pdf_api.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/view/overlay_screen.dart';
import 'package:document_manager_app/widgets/my_textfield.dart';
import 'package:document_manager_app/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, required this.files});

  final List<FileModel> files;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool isVisible = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController expiryDateController = TextEditingController();

  FileModel? pickedFile;

  void showFileListOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FileListOverlay(
          files: widget.files,
          onFileSelected: (file) {
            setState(() {
              pickedFile = file;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  _createDocument() {
    if (_formKey.currentState!.validate() && pickedFile != null) {
      PdfApi.generatePdf(titleController.text, descriptionController.text,
          File(pickedFile!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: const Text("Create PDF"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: titleController,
                labelText: 'Title',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                keyboardType: TextInputType.multiline,
                controller: descriptionController,
                labelText: 'Description',
                maxLines: 8,
                minLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: expiryDateController, labelText: "ExpiryDate"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Attach file:",
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal),
                ),
              ),
              pickedFile == null
                  ? Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey.shade600),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () => showFileListOverlay(context),
                        child: Text(
                          "Choose file",
                          style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.blue[400],
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title(
                              pickedFile?.path ?? "File name",
                            ),
                            style: GoogleFonts.lato(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                          TextButton(
                              style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                              onPressed: () => showFileListOverlay(context),
                              child: Text(
                                "Change file",
                                style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.normal),
                              )),
                        ],
                      ),
                    ),
              Visibility(
                  visible: isVisible,
                  child: Text("Please choose a file",
                      style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.normal))),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: _createDocument, child: const Text("Create"))
            ],
          ),
        ),
      ),
    );
  }
}
