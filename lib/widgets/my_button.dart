import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, this.onPressed, this.backgroundColor, required this.title});

  final void Function()? onPressed;
  final Color? backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
                letterSpacing: 3,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
