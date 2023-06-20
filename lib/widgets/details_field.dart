import 'package:flutter/material.dart';

class DetailsField extends StatelessWidget {
  const DetailsField({
    super.key,
    required this.fieldName,
    required this.fieldValue,
  });

  final String fieldName;
  final String fieldValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            fieldName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              fieldValue,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
