import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavesScreen extends StatelessWidget {
  const SavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          final sp = snapshot.data;
          if (sp == null) {
            final error = snapshot.error;
            if (error == null) {
              return const SizedBox();
            } else {
              return SnapshotErrorDisplay(error);
            }
          } else {
            return const Center(child: Text('It works!'));
          }
        });
  }
}

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
