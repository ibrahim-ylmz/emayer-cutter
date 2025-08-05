import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  bool _isSidebarOpen = true;
  bool get isSidebarOpen => _isSidebarOpen;
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }
}
