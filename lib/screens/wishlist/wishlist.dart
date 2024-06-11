import 'dart:developer';

import 'package:dimplom/model/category/category_model.dart';
import 'package:dimplom/model/course/course_model.dart';
import 'package:dimplom/model/review/review_model.dart';
import 'package:dimplom/model/section/section_model.dart';
import 'package:dimplom/model/tools/tools_model.dart';
import 'package:dimplom/screens/course/model_hive/courses_local_model.dart';
import 'package:dimplom/screens/homescreen/data/cources_model.dart';
import 'package:flutter/material.dart';

import '../../components/course_card.dart';
import '../course/detail_course_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final nfcCardKeysHelper = NfcCardKeysHelper();
  List<CoursesLocalModel> whishList = [];

  @override
  void initState() {
    getList();
    super.initState();
  }

  getList() {
    nfcCardKeysHelper.getCardKeys().then((value) {
      whishList = value;
      setState(() {});
      log('data-unique: value: $value ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Wishlist Course',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: whishList.length,
        itemBuilder: (context, index) {
          final model = whishList[index];
          final coursesId = Courses(
            image: model.image,
            title: model.title,
            video: model.video,
            description: model.description,
            tests: model.tests
                ?.map(
                  (e) => Tests(
                    available: e.available,
                    question: e.question,
                    variants: e.variants
                        ?.map(
                          (e) => Variants(
                            code: e.code,
                            variant: e.variant,
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          );

          List<CourseModel> mockData = List.generate(
            whishList.length,
            (index) => CourseModel(
              id: 1,
              courseName: 'sdk',
              courseImage: 'sdk',
              category: CategoryModel(id: 2),
              description: 'sdk',
              totalVideo: 1,
              totalTime: 'sdk',
              totalRating: 1.3,
              sections: [
                Section(id: 4),
                Section(id: 5),
              ],
              reviews: [
                Review(id: 52),
                Review(id: 51),
              ],
              tools: [
                Tools(id: 4),
              ],
            ),
          );
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) async {
              await nfcCardKeysHelper.deleteById(index);
              // whishList.removeAt(index);
              getList();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${whishList[index].title} Removed'),
                ),
              );
              setState(() {});
            },
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailCourseScreen(
                      isWhishList: true,
                      courseId: coursesId,
                      index: index,
                    ),
                  ),
                );
              },
              child: CourseCard(
                isWhishList: true,
                courseIdModel: coursesId,
                courseImage: coursesId.image ?? '',
                courseName: coursesId.title ?? '',
                rating: mockData[index].totalRating ?? 0,
                totalTime: mockData[index].totalTime ?? '',
                totalVideo: mockData[index].totalVideo.toString(),
              ),
            ),
          );

          // Dismissible(
          //   key: UniqueKey(),
          //   onDismissed: (direction) {
          //     setState(() {
          //       wishlishedCourse.wishlishedCourse?.removeAt(index);
          //     });
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(
          //             '${wishlishedCourse.wishlishedCourse?[index].courseName} Removed'),
          //       ),
          //     );
          //   },
          //   child: GestureDetector(
          //     onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const DetailCourseScreen(
          //           index: 0,
          //           // courseId: wishlishedCourse.wishlishedCourse?[index],
          //         ),
          //       ),
          //     ),
          //     child: CourseCard(
          //       courseImage:
          //           wishlishedCourse.wishlishedCourse?[index].courseImage ?? '',
          //       courseName:
          //           wishlishedCourse.wishlishedCourse?[index].courseName ?? '',
          //       rating:
          //           wishlishedCourse.wishlishedCourse?[index].totalRating ?? 0,
          //       totalTime:
          //           wishlishedCourse.wishlishedCourse?[index].totalTime ?? '',
          //       totalVideo: wishlishedCourse.wishlishedCourse?[index].totalVideo
          //               .toString() ??
          //           '',
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
