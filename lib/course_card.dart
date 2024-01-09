import 'package:flutter/material.dart';

import 'course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    this.course,
    this.delete,
  });

  static const double width = 12 * 12 * 3;
  final Course? course;
  final Function? delete; //FIXME - required

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, //FIXME - hardcoded
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 12 * 12 * 2),
                        child: IntrinsicWidth(
                          child: TextField(
                            style: Theme.of(context).textTheme.titleLarge,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Course Title',
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
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 72,
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: const InputDecoration(
                                hintText: '3',
                                isDense: true,
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
                const SizedBox(height: 8),
                const Divider(
                  color: Colors.black12,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'mark',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'max',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'weight',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    Center(
                      child: Text('Add'),
                    )
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Grade: B+ (84)',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
