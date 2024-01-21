import 'mark.dart';

class CourseDefaults {
  static const name = 'Course Name';
  static const credit = 1;
}

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

  Map<String, dynamic> toMap() => {
        'name': name,
        'credit': credit,
        'marks': marks.map((e) => e.toMap()).toList()
      };

  @override
  String toString() => '{"name": "$name", "credit": $credit, "marks": $marks}';
}
