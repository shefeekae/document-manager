import 'package:document_manager_app/provider/file_picker_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../functions/file_manager.dart';
import 'load_image.dart';

class ChangeFileContainer extends StatelessWidget {
  const ChangeFileContainer({
    super.key,
    required this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    PlatformFile file = Provider.of<FilePickerProvider>(context).pickedFile!;

    return Container(
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //
          SizedBox(
              height: 30,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FileManager.isPdf(file.extension!)
                      ? Image.asset(
                          "assets/pdf-1512.png",
                          fit: BoxFit.cover,
                        )
                      : FileManager.isXlsx(file.extension!)
                          ? Image.asset(
                              "assets/xlsx-file.png",
                              fit: BoxFit.cover,
                            )
                          : loadImage(file.path!))),

          Text(
            file.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ),

          TextButton(
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              onPressed: onPressed,
              child: Text(
                "Change file",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.normal),
              )),
        ],
      ),
    );
  }
}
