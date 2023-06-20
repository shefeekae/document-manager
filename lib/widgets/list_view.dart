import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/widgets/load_image.dart';
import 'package:flutter/material.dart';

class FileListView extends StatelessWidget {
  const FileListView({super.key, required this.fileList});

  final List<FileModel> fileList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemExtent: 120,
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          FileModel file = fileList[index];

          return ListTile(
              leading: Hero(
                tag: file,
                child: SizedBox(
                  height: 60,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FileManager.isPdf(file.documentType)
                        ? Image.asset(
                            "assets/pdf-1512.png",
                            fit: BoxFit.cover,
                          )
                        : FileManager.isXlsx(file.documentType)
                            ? Image.asset(
                                "assets/xlsx-file.png",
                                fit: BoxFit.cover,
                              )
                            : loadImage(file.path),
                  ),
                ),
              ),
              title: Text(
                file.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "${file.modifiedDate} - ${file.size}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () => Navigator.of(context)
                  .pushNamed('/detailsScreen', arguments: file));
        },
      ),
    );
  }
}
