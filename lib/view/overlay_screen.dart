import 'dart:io';

import 'package:document_manager_app/model/file_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FileListOverlay extends StatelessWidget {
  final List<FileModel> files;
  final Function(FileModel)? onFileSelected;

  FileListOverlay({super.key, required this.files, this.onFileSelected});

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Select a file",
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    FileModel file = files[index];
                    return ListTile(
                      title: Text(
                        file.documentType,
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Close the overlay without selecting a file
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
