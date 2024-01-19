import 'package:flutter/material.dart';

class NoSavesFound extends StatelessWidget {
  const NoSavesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No saves found',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
