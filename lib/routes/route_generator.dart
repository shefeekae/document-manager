import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/view/add_screen.dart';
import 'package:document_manager_app/view/details_screen.dart';
import 'package:document_manager_app/view/home_screen.dart';
import 'package:document_manager_app/view/image_screen.dart';
import 'package:document_manager_app/view/pdf_screen.dart';
import 'package:document_manager_app/view/search_screen.dart';
import 'package:document_manager_app/view/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      case '/searchScreen':
        if (args is List<FileModel>) {
          return MaterialPageRoute(
              builder: (context) => SearchScreen(
                    files: args,
                  ));
        } else {
          return errorRoute();
        }

      case '/addScreen':
        if (args is List<FileModel>) {
          return MaterialPageRoute(
            builder: (context) => AddScreen(files: args),
          );
        } else {
          return errorRoute();
        }

      case '/detailsScreen':
        if (args is FileModel) {
          return MaterialPageRoute(
              builder: (context) => DetailsScreen(file: args));
        } else {
          return errorRoute();
        }

      case '/imageViewer':
        if (args is FileModel) {
          return MaterialPageRoute(
            builder: (context) => ImageViewer(file: args),
          );
        } else {
          return errorRoute();
        }

      case '/pdfViewer':
        if (args is FileModel) {
          return MaterialPageRoute(
            builder: (context) => PdfViewer(file: args),
          );
        } else {
          return errorRoute();
        }

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(
            child: Text('There is Some error in the routing'),
          ),
        );
      },
    );
  }
}
