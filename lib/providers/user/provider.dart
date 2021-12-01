import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UserProvider with ChangeNotifier {
  String _email = "";

  String get email => _email;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user_email.txt');
  }

  Future<File> writeUserEmail(String email) async {
    final file = await _localFile;
    _email = email;
    return file.writeAsString('$email');
  }

  Future<String> readUserEmail() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      _email = contents;
      return contents;
    } catch (e) {
      return "";
    }
  }
}
