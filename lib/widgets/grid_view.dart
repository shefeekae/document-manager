import 'package:document_manager_app/functions/file_manager.dart';
import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/widgets/load_image.dart';
import 'package:flutter/material.dart';

class FileGridView extends StatelessWidget {
  const FileGridView({
    super.key,
    required this.fileList,
  });

  final List<FileModel> fileList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 100,
          crossAxisSpacing: 10,
          mainAxisExtent: 150,
          crossAxisCount: 3),
      itemCount: fileList.length,
      itemBuilder: (context, index) {
        FileModel file = fileList[index];
        return GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed('/detailsScreen', arguments: file),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Hero(
                  tag: file,
                  child: SizedBox(
                    height: 100,
                    width: 60,
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
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                file.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                file.modifiedDate,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                file.size,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      },
    ));
  }
}
