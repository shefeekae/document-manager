import 'package:flutter/material.dart';

class ToggleViewProvider extends ChangeNotifier {
  bool isGridView = false;

  //Method for toggling grid view and list view

  toggleView() {
    isGridView = !isGridView;
    notifyListeners();
  }
}
