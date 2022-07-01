import 'package:flutter/material.dart';

class EditorProvider extends ChangeNotifier {
  bool _isEditor = false;

  bool isEditor() => _isEditor;

  void setEditor(bool isEditor) {
    _isEditor = isEditor;
    notifyListeners();
  }
}
