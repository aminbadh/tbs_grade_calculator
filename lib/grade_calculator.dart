import 'package:flutter/material.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  static const double sep = 12 * 2;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: sep),
          DocTitle(),
          SizedBox(height: sep),
          CourseCard(),
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
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ],
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
