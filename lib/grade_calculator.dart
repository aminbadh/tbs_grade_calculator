import 'package:flutter/material.dart';

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
