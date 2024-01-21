import 'course.dart';

class DocumentDefaults {
  static const title = 'Untitled';
}

class Document {
  late String title;
  late List<Course> courses;

  Document({title, courses}) {
    this.title = title ?? '';
    this.courses = courses ?? [Course()];
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    final courses = <Course>[];
    for (final course in json['courses']) {
      courses.add(Course.fromJson(course));
    }
    return Document(
      title: json['title'],
      courses: courses,
    );
  }

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

  Map<String, dynamic> toMap() =>
      {'title': title, 'courses': courses.map((e) => e.toMap()).toList()};

  @override
  String toString() => '{"title": "$title", "courses": $courses}';
}

String letter(double grade) {
  if (grade < 60) return 'F';
  if (grade < 65) return 'D';
  if (grade < 67) return 'D+';
  if (grade < 70) return 'C-';
  if (grade < 73) return 'C';
  if (grade < 77) return 'C+';
  if (grade < 80) return 'B-';
  if (grade < 83) return 'B';
  if (grade < 87) return 'B+';
  if (grade < 90) return 'A-';
  return 'A';
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
