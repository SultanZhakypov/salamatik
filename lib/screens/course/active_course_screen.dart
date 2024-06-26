import 'package:dimplom/model/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/course_card.dart';
import '../screen.dart';

class ActiveCourseScreen extends StatefulWidget {
  const ActiveCourseScreen({Key? key}) : super(key: key);

  @override
  State<ActiveCourseScreen> createState() => _ActiveCourseScreenState();
}

class _ActiveCourseScreenState extends State<ActiveCourseScreen> {
  @override
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).getEnrolledCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      body: FutureBuilder(
        future: user.getEnrolledCourse(),
        builder: (context, snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: user.enrolledCourse.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LearningCourseScreen(
                        courseId: user.enrolledCourse[index],
                        initURL: user.enrolledCourse[index].course?.sections?[0]
                            .materials?[0].url,
                      ),
                    ),
                  );
                },
                child: CourseCard(
                  courseImage:
                      user.enrolledCourse[index].course?.courseImage ?? '',
                  courseName:
                      user.enrolledCourse[index].course?.courseName ?? '',
                  rating: user.enrolledCourse[index].course?.totalRating ?? 0,
                  totalTime: user.enrolledCourse[index].course?.totalTime ?? '',
                  totalVideo: user.enrolledCourse[index].course?.totalVideo
                          .toString() ??
                      '',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
