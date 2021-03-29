import 'package:flutter/material.dart';

class Admin with ChangeNotifier {
  bool isAdmin;

  bool get getAdmin => isAdmin;
  void setAdmin(bool isAdm) {
    isAdmin = isAdm;
  }
}
