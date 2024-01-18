import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../doc_state.dart';
import '../models/document.dart';

class DocumentActions extends StatelessWidget {
  const DocumentActions({
    super.key,
  });

  void _save(Document document) async {
    final sp = await SharedPreferences.getInstance();
    final key = "${document.title}.${DateTime.now().millisecondsSinceEpoch}";

    final documents = sp.getStringList(documentsKey) ?? [];
    documents.add(key);

    sp.setStringList(documentsKey, documents);
    sp.setString(key, document.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _save(context.read<DocState>().document),
          child: const Text('Save'),
        ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: () =>
                // ignore: avoid_print
                print(context.read<DocState>().document.toString()),
            child: const Text('Debug'),
          ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: context.read<DocState>().refresh,
            child: const Text('Refresh'),
          ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Share'),
        ),
      ],
    );
  }
}
