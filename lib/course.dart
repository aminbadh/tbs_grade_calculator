class Course {
  var title = '';
  var credit = -1;
  var marks = <Mark>[Mark()];

  @override
  String toString() =>
      '{title = "$title", credit = $credit, ' 'marks = $marks}';
}

class Mark {
  var mark = -1;
  var max = -1;
  var weight = -1;

  @override
  String toString() => '{mark = $mark, max = $max, weight = $weight}';
}
