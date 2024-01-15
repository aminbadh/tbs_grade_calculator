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

  // No need to notify listeners because in
  // case of a rebuild the value will be updated
  // if not, it will use the controller's value
  void setTitle(String title) {
    document.title = title;
  }
}
