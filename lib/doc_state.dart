import 'package:flutter/material.dart';

import 'models/course.dart';
import 'models/document.dart';

class DocState extends ChangeNotifier {
  late final Document document;

  DocState([Document? document]) {
    this.document = document ?? Document();
  }

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
