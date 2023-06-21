import 'dart:io';
import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class FileListOverlay extends StatelessWidget {
  final List<FileModel> files;
  final Function(FileModel)? onFileSelected;

  const FileListOverlay({super.key, required this.files, this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    List<FileModel> imageList = [];
    imageList = FileManager.filterImages(files);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 400,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a file",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: imageList.isNotEmpty,
                replacement: const Center(
                  child: Text(
                    "No files",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                child: Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(7)),
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                      ),
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        FileModel? file = imageList[index];
                        return ListTile(
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(file.path),
                                    fit: BoxFit.cover,
                                  ))),
                          title: Text(
                            file.title,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            if (onFileSelected != null) {
                              onFileSelected!(file);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              MyButton(
                onPressed: () {
                  // Close the overlay without selecting a file
                  Navigator.pop(context);
                },
                title: "Cancel",
                backgroundColor: const Color.fromARGB(255, 242, 92, 69),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
