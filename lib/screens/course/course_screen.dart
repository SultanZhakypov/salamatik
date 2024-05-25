import 'dart:developer';

import 'package:dimplom/components/course_card.dart';
import 'package:dimplom/model/category/category_model.dart';
import 'package:dimplom/model/course/course_model.dart';
import 'package:dimplom/model/course/course_viewmodel.dart';
import 'package:dimplom/model/review/review_model.dart';
import 'package:dimplom/model/section/section_model.dart';
import 'package:dimplom/model/tools/tools_model.dart';
import 'package:dimplom/screens/course/detail_course_screen.dart';
import 'package:dimplom/screens/homescreen/presentation/cubit/home_cubit.dart';
import 'package:dimplom/screens/homescreen/presentation/page/child_page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../model/choiceChip/choice_chip_data.dart';
import '../../model/choiceChip/choice_chip_model.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool isEmpty = false;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  TextEditingController controller = TextEditingController();
  final List categories = [
    'All',
    'Backend Engineer',
    'Frontend Engineer',
    'Mobile Developer',
    'UI/UX Designer',
  ];

  @override
  void initState() {
    Provider.of<CourseViewModel>(context, listen: false).getAllCourse();
    context.read<HomeCubit>().getCoursesCubit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Course Learning',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: FloatingBottomArea(
        areaContent: GestureDetector(
          onTap: () async {},
          child: Container(
            margin: const EdgeInsets.only(bottom: 15, right: 16, left: 16),
            height: 55,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: const Text('Ссылка'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SearchBar(),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  hintText: 'Search course...',
                ),
                onChanged: (val) {
                  // course.searchCourseByName(val);
                },
              ),
              const SizedBox(height: 8),
              //Filter ChoiceChip ROW
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: choiceChips
                                .map(
                                  (choiceChip) => ChoiceChip(
                                    label: Text(choiceChip.label!),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    selected: choiceChip.isSelected,
                                    selectedColor: const Color(0xFF126E64),
                                    backgroundColor: Colors.grey[500],
                                    onSelected: (isSelected) => setState(() {
                                      choiceChips =
                                          choiceChips.map((otherChip) {
                                        final newChip =
                                            otherChip.copy(isSelected: false);
                                        return choiceChip == newChip
                                            ? newChip.copy(
                                                isSelected: isSelected)
                                            : newChip;
                                      }).toList();
                                      // course.filterCourseByCategory(
                                      //   choiceChip.label!,
                                      // );
                                      //////////////////setState//////////////////
                                    }),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CoursesSuccess) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.courses.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailCourseScreen(
                                    courseId: state.courses[index],
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: CourseCard(
                              courseImage: state.courses[index].image ?? '',
                              courseName: state.courses[index].title ?? '',
                              rating: mockData[index].totalRating ?? 0,
                              totalTime: mockData[index].totalTime ?? '',
                              totalVideo: mockData[index].totalVideo.toString(),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<CourseModel> mockData = [
  CourseModel(
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
  CourseModel(
    id: 6,
    courseName: 'sdk',
    courseImage: 'sdk',
    category: CategoryModel(id: 2),
    description: 'sdk',
    totalVideo: 50,
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
];
