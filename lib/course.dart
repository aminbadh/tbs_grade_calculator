class Course {
  var title = '';
  var credit = -1;
  var marks = <Mark>[Mark()];

  @override
  String toString() =>
      '{title = "$title", credit = $credit, ' 'marks = $marks}';
}

class Mark {
  var mark = 80;
  var max = 100;
  var weight = 10;

  @override
  String toString() => '{mark = $mark, max = $max, weight = $weight}';
}
