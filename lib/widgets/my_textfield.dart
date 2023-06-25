import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    // required this.labelText,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.validator,
  });

  // final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey.shade800),
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: const Color.fromARGB(255, 55, 126, 94),
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          // labelText: labelText,
          // labelStyle: GoogleFonts.lato(
          //     fontSize: 15,
          //     color: Colors.grey.shade600,
          //     fontWeight: FontWeight.normal),
          fillColor: Colors.grey[200],
          filled: true,

          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              )),
        ),
      ),
    );
  }
}
