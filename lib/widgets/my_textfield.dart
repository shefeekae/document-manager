import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.validator,
  });

  final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      // height: size.height * .068,
      // width: double.infinity,
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: Colors.deepPurple,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          labelText: labelText,
          labelStyle: GoogleFonts.lato(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.normal),
          fillColor: Colors.grey[200],
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              )),
        ),
      ),
    );
  }
}
