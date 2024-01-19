class Course {
  late String name;
  int? credit;
  late List<Mark> marks;

  Course({name, this.credit, marks}) {
    this.name = name ?? '';
    this.marks = marks ?? [Mark()];
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    final marks = <Mark>[];
    for (final mark in json['marks']) {
      marks.add(Mark.fromJson(mark));
    }
    return Course(
      name: json['name'],
      credit: json['credit'],
      marks: marks,
    );
  }

  // Returns a non-nullable credit value
  int get getCredit => credit ?? CourseDefaults.credit;

  double get grade {
    double total = 0, weights = 0;
    for (final mark in marks) {
      total += (mark.getMark / mark.getMax) * mark.getWeight;
      weights += mark.getWeight;
    }
    return total / weights * 100;
  }

  @override
  String toString() => '{"name": "$name", "credit": $credit, "marks": $marks}';
}

class Mark {
  double? mark, max, weight;

  Mark({this.mark, this.weight, this.max});

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      mark: json['mark'],
      max: json['max'],
      weight: json['weight'],
    );
  }

  // Returns non-nullable values
  double get getMark => mark ?? MarkDefaults.mark;
  double get getMax => max ?? MarkDefaults.max;
  double get getWeight => weight ?? MarkDefaults.weight;

  @override
  String toString() => '{"mark": $mark, "max": $max, "weight": $weight}';
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

class MarkDefaults {
  static const double mark = 37.5;
  static const double max = 40;
  static const double weight = 60;
}
