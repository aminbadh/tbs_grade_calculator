class MarkDefaults {
  static const double mark = 37.5;
  static const double max = 40;
  static const double weight = 60;
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

  Map<String, dynamic> toMap() => {'mark': mark, 'max': max, 'weight': weight};

  @override
  String toString() => '{"mark": $mark, "max": $max, "weight": $weight}';
}
