import 'package:flutter/material.dart';

import 'course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    this.course,
    this.delete,
  });

  static const double width = 12 * 12 * 3.5;
  final Course? course;
  final Function? delete; //FIXME - required

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: width),
        decoration: BoxDecoration(
          color: Colors.white, //FIXME - hardcoded
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 20),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Course Name',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 72,
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            hintText: '3',
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 0,
                              ),
                            ),
                            suffixIcon: Icon(
                              size: 24,
                              Icons.bolt,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              height: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mark',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Weight',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        InkWell(
                          //TODO - onTap
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.add_rounded, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  MarkRow(),
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Grade: A (92.16)',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Remove',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkRow extends StatelessWidget {
  const MarkRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: '100',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: '100',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: '100',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: InkWell(
              //TODO - onTap
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.remove_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
