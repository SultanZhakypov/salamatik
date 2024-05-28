import 'dart:developer';

import 'package:dimplom/screens/course/course_screen.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String courseImage;
  String courseName;
  String? mentorName;
  String totalVideo;
  String totalTime;
  double? rating;

  CourseCard(
      {super.key,
      required this.courseImage,
      required this.courseName,
      this.mentorName,
      this.rating,
      required this.totalTime,
      required this.totalVideo});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final isOpened = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    bool isAvailable = true;
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          isOpened.value = false;
        }
        if (details.delta.dx < 0) {
          isOpened.value = true;
        }
        log('data-unique: 1 ');
      },
      child: Container(
        height: 116,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ValueListenableBuilder(
          valueListenable: isOpened,
          builder: (_, __, child) {
            return Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Positioned(
                  right: 15,
                  child: Transform.rotate(
                    angle: 4.70,
                    child: const ShimmerArrows(),
                  ),
                ),
                AnimatedContainer(
                  width: isOpened.value ? 60 : 0,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedItemForDop(
                        icon: Icons.bookmark_rounded,
                        text: 'Wishlist',
                        isOpened: isOpened,
                      ),
                      // AnimatedItemForDop(
                      //   icon: Icons.access_alarm,
                      //   text: 'Alarm',
                      //   isOpened: isOpened,
                      // ),
                      // AnimatedItemForDop(
                      //   icon: Icons.access_alarm,
                      //   text: 'Alarm',
                      //   isOpened: isOpened,
                      // )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                widget.courseImage,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, Object exception, stackTrace) {
                                  return Image.asset(
                                    'assets/empty_image.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              left: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                width: 36,
                                height: 18,
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      Text('${widget.rating}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        width: 100,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.courseName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(radius: 8),
                                SizedBox(width: 8),
                                Text(''),
                                // isAvailable ? mentorName! : '',
                              ],
                            ),
                            Row(
                              children: [
                                GreenChipWidget(
                                  icon: Icons.timelapse,
                                  label: widget.totalTime,
                                ),
                                const SizedBox(width: 8),
                                GreenChipWidget(
                                  icon: Icons.videocam,
                                  label: '${widget.totalVideo} Video',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GreenChipWidget extends StatelessWidget {
  GreenChipWidget({super.key, required this.icon, required this.label});

  IconData icon;
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFC3CFCE),
      ),
      width: 74,
      height: 20,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 16),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class AnimatedItemForDop extends StatelessWidget {
  const AnimatedItemForDop({
    super.key,
    required this.icon,
    required this.text,
    required this.isOpened,
  });

  final ValueNotifier<bool> isOpened;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to Wishlist!')),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(1.1, 1.1),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(height: 2.5),
              SizedBox(
                height: 16,
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
