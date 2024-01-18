import 'course.dart';

const String documentsKey = 'documents';

class Document {
  var title = '';
  var courses = <Course>[Course()];

  int get registeredCredit {
    var credit = 0;
    for (final course in courses) {
      credit += course.getCredit;
    }
    return credit;
  }

  int get earnedCredit {
    var credit = 0;
    for (final course in courses) {
      if (course.grade >= 60) credit += course.getCredit;
    }
    return credit;
  }

  double get gpa {
    var gpa = 0.0;
    for (final course in courses) {
      gpa += gpv(letter(course.grade)) * course.getCredit;
    }
    return gpa / registeredCredit;
  }

  @override
  String toString() => '{title = "$title", courses = $courses}';
}

double gpv(String letter) {
  switch (letter) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    case 'B-':
      return 2.7;
    case 'C+':
      return 2.3;
    case 'C':
      return 2.0;
    case 'C-':
      return 1.7;
    case 'D+':
      return 1.3;
    case 'D':
      return 1.0;
    default:
      return 0.0;
  }
}

class DocumentDefaults {
  static const title = 'Untitled';
}
