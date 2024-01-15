import 'package:flutter/material.dart';

import 'course.dart';
import 'document.dart';

class DocState extends ChangeNotifier {
  final document = Document();

  List<Course> get courses => document.courses;

  void add() {
    courses.add(Course());
    notifyListeners();
  }

  void remove(Course course) {
    courses.remove(course);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
