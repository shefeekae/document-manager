import 'package:document_manager_app/provider/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseFileContainer extends StatelessWidget {
  const ChooseFileContainer({super.key, required this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Provider.of<Validate>(context).isFileValid
            ? Border.all(color: Colors.grey.shade400)
            : Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
        onPressed: onPressed,
        child: Text(
          "Choose file",
          style: TextStyle(
              fontSize: 15,
              color: Colors.green.shade400,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
