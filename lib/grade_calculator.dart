import 'package:flutter/material.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 12 * 2),
          Opacity(
            opacity: .7, // TODO - Make this part of the Theme
            child: TextField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
              decoration: const InputDecoration(
                hintText: 'Untitled',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 12 * 2),
          const CourseCard(),
        ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.titleLarge,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Course Title',
                border: InputBorder.none,
              ),
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Course Code',
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            const Column(
              children: [
                Row(
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
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
    );
  }
}
