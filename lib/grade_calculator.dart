import 'package:flutter/material.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  static const double sep = 12 * 2;

  @override
  Widget build(BuildContext context) {
    var rows = (MediaQuery.of(context).size.width - 100) / CourseCard.width;
    if (--rows < 1) rows = 1;
    var rowCh = <Widget>[];

    for (var i = 0; i < rows; i++) {
      rowCh.add(
        Column(
          children: [
            CourseCard(),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: sep),
          DocTitle(),
          SizedBox(height: sep),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: rowCh,
          ),
        ],
      ),
    );
  }
}

//TODO - Add opacity factor
class DocTitle extends StatelessWidget {
  const DocTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: const InputDecoration(
        hintText: 'Untitled',
        border: InputBorder.none,
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    this.delete,
  });

  static const double width = 12 * 12 * 3;
  final Function? delete; //FIXME - required

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        surfaceTintColor: Colors.white, //FIXME - hardcoded
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Course Title',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Text(
                  '3',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Icon(
                  Icons.bolt,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ]),
              const Divider(),
              const Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'mark',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'max',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'weight',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              const Divider(),
              Row(
                children: [
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Grade: B+ (84)',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Remove',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*TextField(
  style: Theme.of(context).textTheme.bodyMedium,
  decoration: const InputDecoration(
    isDense: true,
    hintText: 'Course Code',
    border: InputBorder.none,
  ),
),*/
