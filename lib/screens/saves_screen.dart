import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbs_grade_calculator/utils.dart';

import '../components/no_saves_found.dart';
import '../components/snapshot_error.dart';
import '../models/document.dart';

class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  State<SavesScreen> createState() => _SavesScreenState();
}

class _SavesScreenState extends State<SavesScreen> {
  int _mil(String s) => int.parse(s.substring(s.lastIndexOf('.') + 1));

  int _comp(String a, String b) => _mil(b) - _mil(a);

  List<Widget> _children(List<String> keys) => keys.map((key) {
        final mil = _mil(key), title = key.replaceAll('.$mil', '');
        return ListTile(
          title: Text(title.isEmpty ? DocumentDefaults.title : title),
          subtitle: Text(DateTime.fromMillisecondsSinceEpoch(mil).toString()),
          trailing: IconButton(
            onPressed: () async {
              (await SharedPreferences.getInstance()).remove(key);
              setState(() {});
            },
            icon: const Icon(Icons.delete_forever),
          ),
          onTap: () => Navigator.of(context).pushNamed('/$key'),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            final error = snapshot.error;
            if (error == null) {
              return emptyWidget;
            } else {
              return SnapshotErrorDisplay(error);
            }
          } else {
            final keys = data.getKeys()..removeAll(usedKeys);
            if (keys.isEmpty) {
              return const NoSavesFound();
            } else {
              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: _children(keys.toList()..sort(_comp)),
              );
            }
          }
        });
  }
}
