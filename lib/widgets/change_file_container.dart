import 'dart:io';
import 'package:flutter/material.dart';
import '../model/file_model.dart';

class ChangeFileContainer extends StatelessWidget {
  const ChangeFileContainer(
      {super.key, required this.onPressed, required this.pickedFile});

  final Function()? onPressed;
  final FileModel? pickedFile;

  @override
  Widget build(BuildContext context) {
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
                  child: Image.file(File(pickedFile!.path)))),

          Text(
            pickedFile?.title ?? "File name",
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
