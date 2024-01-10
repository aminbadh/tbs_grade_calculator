import 'package:flutter/material.dart';

import 'course.dart';

class DocState extends ChangeNotifier {
  var courses = <Course>[Course()];

  void add() {
    courses.add(Course());
    notifyListeners();
  }

  void remove(Course course) {
    courses.remove(course);
    notifyListeners();
  }

  void printCourses() {
    print(courses);
  }
}
