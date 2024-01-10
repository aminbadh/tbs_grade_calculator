import 'package:flutter/material.dart';

import 'course.dart';

class DocState extends ChangeNotifier {
  var courses = <Course>[Course()];

  void add() {
    courses.add(Course());
    notifyListeners();
  }

  void remove(int index) {
    courses.removeAt(index);
    notifyListeners();
  }
}
