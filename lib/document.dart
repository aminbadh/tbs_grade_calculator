import 'course.dart';

class Document {
  var title = 'Untitled';
  var courses = <Course>[Course()];

  @override
  String toString() => '{title = "$title", courses = $courses}';
}
