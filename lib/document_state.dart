import 'package:flutter/material.dart';

import 'course.dart';
import 'document.dart';

class DocState extends ChangeNotifier {
  final document = Document();

  List<Course> get courses {
    return document.courses;
  }

  void add() {
    courses.add(Course());
    notifyListeners();
  }

  void remove(int index) {
    courses.removeAt(index);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
