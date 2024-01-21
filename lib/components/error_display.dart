import 'package:flutter/material.dart';

class SnapshotErrorDisplay extends StatelessWidget {
  const SnapshotErrorDisplay(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Error',
              style: theme.textTheme.bodyLarge?.copyWith(
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
            const SizedBox(height: 12),
            Text(
              'Contact me or create an issue on GitHub',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
