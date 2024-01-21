import 'package:flutter/material.dart';

class StackBackButton extends StatelessWidget {
  const StackBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Navigator.of(context).canPop()) return const SizedBox();
    return Positioned(
      top: 12,
      left: 16,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(24),
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
    );
  }
}
