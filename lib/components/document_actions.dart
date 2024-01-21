import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifiers/document_state.dart';
import '../models/document.dart';
import '../utils.dart';

class DocumentActions extends StatelessWidget {
  const DocumentActions({
    super.key,
  });

  void _localSave(Document document, ScaffoldMessengerState messenger) async {
    final key = "${document.title}.${DateTime.now().millisecondsSinceEpoch}";
    (await SharedPreferences.getInstance())
        .setString(key, jsonEncode(document.toMap()))
        .then((value) => showSnackbar(messenger, 'Saved!'));
  }

  void _cloudSave(Document document, ScaffoldMessengerState messenger) async {
    if (FirebaseAuth.instance.currentUser == null) await signIn(messenger);
    if (FirebaseAuth.instance.currentUser == null) return;

    try {
      await FirebaseFirestore.instance.collection('documents').add({
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'owner': FirebaseAuth.instance.currentUser!.uid,
        'document': document.toMap(),
        'public': false,
      }).then((value) => showSnackbar(messenger, 'Saved!'));
    } catch (e) {
      showSnackbar(messenger, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      overflowButtonSpacing: 18,
      children: [
        ElevatedButton(
          onPressed: () => _localSave(
            context.read<DocumentState>().document,
            ScaffoldMessenger.of(context),
          ),
          child: const Text('Local Save'),
        ),
        ElevatedButton(
          onPressed: () => _cloudSave(
            context.read<DocumentState>().document,
            ScaffoldMessenger.of(context),
          ),
          child: const Text('Cloud Save'),
        ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: () =>
                // ignore: avoid_print
                print(context.read<DocumentState>().document),
            child: const Text('Debug'),
          ),
        if (kDebugMode)
          ElevatedButton(
            onPressed: context.read<DocumentState>().refresh,
            child: const Text('Refresh'),
          ),
      ],
    );
  }
}
