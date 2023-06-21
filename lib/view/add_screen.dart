import 'package:document_manager_app/controller/pdf_controller.dart';
import 'package:document_manager_app/functions/validation.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/validation.dart';
import 'package:document_manager_app/view/overlay_screen.dart';
import 'package:document_manager_app/widgets/change_file_container.dart';
import 'package:document_manager_app/widgets/choose_file_container.dart';
import 'package:document_manager_app/widgets/my_button.dart';
import 'package:document_manager_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/text_field_title.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, required this.files});

  final List<FileModel> files;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  GeneratePdfController generatePdfController = GeneratePdfController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  FileModel? pickedFile;

  Validation validate = Validation();

//Shows an overlay screen with a list of images.
  void showFileListOverlay() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FileListOverlay(
          files: widget.files,
          onFileSelected: (file) {
            setState(() {
              pickedFile = file;
              Provider.of<Validate>(context, listen: false)
                  .checkFile(pickedFile);
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

//This method calls the method for creating the pdf
  _createDocument() {
    generatePdfController.createDocument(_formKey, context, pickedFile,
        titleController.text, descriptionController.text);
    setState(() {
      titleController.text = '';
      descriptionController.text = '';
      pickedFile = null;
    });
  }

//Dispose off the text controllers
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //Dismissing the keyboard on tapping anywhere on the screen
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/homeScreen');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "Create Pdf",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),

                //Title field
                const TextFieldTitle(title: "Title:"),
                MyTextField(
                  controller: titleController,
                  // labelText: 'Title',
                  validator: (value) => validate.validateTitle(value),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Description field
                const TextFieldTitle(title: "Description:"),
                MyTextField(
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  // labelText: 'Description',
                  maxLines: 8,
                  minLines: 5,
                  validator: (value) => validate.validateDescription(value),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Attach file field
                const TextFieldTitle(title: "Attach file:"),
                pickedFile == null
                    ? ChooseFileContainer(onPressed: showFileListOverlay)
                    : ChangeFileContainer(
                        onPressed: showFileListOverlay, pickedFile: pickedFile),
                Visibility(
                    visible: !Provider.of<Validate>(context).isFileValid,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text("Please choose a file",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.normal)),
                    )),
                SizedBox(
                  height: size.height * .2,
                ),
                // Create button
                MyButton(
                  title: "Create",
                  backgroundColor: const Color.fromARGB(255, 55, 126, 94),
                  onPressed: _createDocument,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
