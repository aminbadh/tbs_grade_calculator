import 'package:flutter/material.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(height: 48),
      const GradeTitle(),
      const SizedBox(height: 24),
    ];

    if (MediaQuery.of(context).size.width - 144 > CourseCard.width * 2) {
      children.add(const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CourseCard(),
          CourseCard(),
        ],
      ));
    } else {
      children.add(const CourseCard());
    }

    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class GradeTitle extends StatelessWidget {
  const GradeTitle({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: width,
        child: Card(
          surfaceTintColor: Colors.white, //FIXME - hardcoded
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
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
                    const SizedBox(width: 12),
                    const Expanded(
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
