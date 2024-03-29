import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/course_card.dart';

Color scaffoldBackgroundColor(BuildContext context) => Color.alphaBlend(
      Theme.of(context).colorScheme.onBackground.withOpacity(0.015),
      Theme.of(context).colorScheme.background,
    );

const Set<String> usedKeys = {'documents'};

const emptyWidget = SizedBox.shrink();

String getFooterMessage() {
  final list = ['w/ Flutter', 'in 7ay 3icha'];
  return list[Random().nextInt(list.length)];
}

bool small(BuildContext context) =>
    MediaQuery.of(context).size.width < CourseCard.width;

void showSnackbar(ScaffoldMessengerState messenger, String text) =>
    messenger.showSnackBar(SnackBar(content: Text(text)));

Future<UserCredential?> signIn([ScaffoldMessengerState? messenger]) async {
  try {
    return (await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider()));
  } catch (e) {
    if (messenger != null) showSnackbar(messenger, e.toString());
    return null;
  }
}
