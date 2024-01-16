import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        children: [
          Text(
            '404',
            style: TextStyle(fontSize: 200, color: Colors.black12),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Text(
              'page not found',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
