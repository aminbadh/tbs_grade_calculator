class Course {
  var name = '';
  int? credit;
  var marks = <Mark>[Mark()];

  // Returns a non-nullable credit value
  int get getCredit {
    return credit ?? CourseDefaults.credit;
  }

  double get grade {
    double total = 0, weights = 0;
    for (final mark in marks) {
      total += (mark.mark / mark.max) * mark.weight;
      weights += mark.weight;
    }
    return total / weights * 100;
  }

  @override
  String toString() => '{title = "$name", credit = $credit, ' 'marks = $marks}';
}

class Mark {
  double mark = 80;
  double max = 100;
  double weight = 10;

  @override
  String toString() => '{mark = $mark, max = $max, weight = $weight}';
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

class CourseDefaults {
  static const name = 'Course Name';
  static const credit = 1;
}
