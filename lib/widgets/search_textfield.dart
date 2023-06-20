import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.onChanged,
    this.onTap,
    required this.autofocus,
    this.searchController,
    required this.readOnly,
  });

  final Function(String)? onChanged;
  final Function()? onTap;
  final bool autofocus;
  final TextEditingController? searchController;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 0,
      child: TextField(
        controller: searchController,
        onTap: onTap,
        onChanged: onChanged,
        autofocus: autofocus,
        readOnly: readOnly,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25)),
            contentPadding: const EdgeInsets.all(6),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: "Search",
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.grey),
      ),
    );
  }
}
