import 'dart:math';

import 'package:flutter/material.dart';

Color scaffoldBackgroundColor(BuildContext context) => Color.alphaBlend(
      Theme.of(context).colorScheme.onBackground.withOpacity(0.015),
      Theme.of(context).colorScheme.background,
    );

const Set<String> usedKeys = {'documents'};

const emptyWidget = SizedBox.shrink();

String getFooterMessage() {
  final _ = ['w/ Flutter', 'in 7ay 3icha'];
  return _[Random().nextInt(_.length)];
}


