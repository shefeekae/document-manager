import 'package:document_manager_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

//This is the permission screen
class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key, required this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to File Craft.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Image.asset(
                'assets/avatar_writing-5kJdV6Aej-transformed.png',
                scale: 4,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                "Please provide an access to your device storage, which is required for fetching files.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),

              //Allow Access Button
              MyButton(
                backgroundColor: const Color.fromARGB(255, 28, 141, 86),
                onPressed: onPressed,
                title: "Go to settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
