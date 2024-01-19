import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/document.dart';

class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  State<SavesScreen> createState() => _SavesScreenState();
}

class _SavesScreenState extends State<SavesScreen> {
  late SharedPreferences sp;

  List<Widget> _children(List<String> keys) => keys.map((key) {
        final sep = key.lastIndexOf('.');
        final mil = int.parse(key.substring(sep + 1));
        final title = key.substring(0, sep);

        return ListTile(
          title: Text(title.isEmpty ? DocumentDefaults.title : title),
          subtitle: Text(DateTime.fromMillisecondsSinceEpoch(mil).toString()),
          trailing: IconButton(
            onPressed: () => setState(() => _delete(key)),
            icon: const Icon(Icons.delete_forever),
          ),
          onTap: () => Navigator.of(context).pushNamed('/$key'),
        );
      }).toList();

  void _delete(String key) {
    final documents = sp.getStringList(documentsKey) ?? [];
    documents.remove(key);
    sp.setStringList(documentsKey, documents);
    sp.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            final error = snapshot.error;
            if (error == null) {
              return const SizedBox();
            } else {
              return SnapshotErrorDisplay(error);
            }
          } else {
            sp = data;
            final keys = sp.getStringList(documentsKey);
            if (keys == null || keys.isEmpty) {
              return const Center(child: Text('No saves found'));
            } else {
              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: _children(keys.reversed.toList()),
              );
            }
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
