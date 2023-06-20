import 'package:flutter/material.dart';

class ChooseFileContainer extends StatelessWidget {
  const ChooseFileContainer({super.key, required this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey.shade400),
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
