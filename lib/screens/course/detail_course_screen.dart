import 'dart:developer';

import 'package:dimplom/components/disabled_enroll_bottom_bar.dart';
import 'package:dimplom/model/profile/profile_viewmodel.dart';
import 'package:dimplom/screens/homescreen/data/cources_model.dart';
import 'package:dimplom/screens/homescreen/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../components/enroll_bottom_bar.dart';
import '../../components/review_card.dart';
import '../../model/course/course_viewmodel.dart';

class DetailCourseScreen extends StatefulWidget {
  final Courses? courseId;
  final int index;
  final bool isWhishList;
  const DetailCourseScreen({
    super.key,
    this.courseId,
    required this.index,
    this.isWhishList = false,
  });

  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

class _DetailCourseScreenState extends State<DetailCourseScreen> {
  bool isDisabled = false;
  @override
  void initState() {
    // Provider.of<CourseViewModel>(context, listen: false)
    //     .getCourseById(widget.courseId!.id!);
    // Provider.of<CourseViewModel>(context, listen: false)
    //     .getAllReviewByCourseId(widget.courseId!.id!);
    Provider.of<ProfileViewModel>(context, listen: false).getEnrolledCourse();
    checkIsEnrolled();
    super.initState();
  }

//description
  checkIsEnrolled() async {
    final enrolled = Provider.of<ProfileViewModel>(context, listen: false);

    // if (enrolled.enrolledCourse
    //     .any((e) => e.course?.courseName == widget.courseId!.courseName)) {
    //   setState(() {
    //     isDisabled = true;
    //   });
    // }
  }

  //

  @override
  Widget build(BuildContext context) {
    checkIsEnrolled();
    log('data-unique: widget.courseId: ${widget.courseId} ');

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(62, 158, 158, 158),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.chevron_left_outlined,
                      color: Colors.white),
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(color: Colors.white),
            centerTitle: true,
            flexibleSpace: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.courseId!.image!),
                  onError: (exception, stackTrace) {
                    Image.asset(
                      'assets/empty_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color(0xFF126E64).withOpacity(1),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.courseId!.title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.zero,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: YoutubePlayer(
                                    bottomActions: [
                                      CurrentPosition(),
                                      ProgressBar(isExpanded: true),
                                      RemainingDuration(),
                                    ],
                                    controller: YoutubePlayerController(
                                      initialVideoId:
                                          YoutubePlayer.convertUrlToId(
                                                  widget.courseId!.video ??
                                                      '') ??
                                              '',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.play_circle_outline_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Preview Course',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            title: const Text(
              'Details Course',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actions: [
              if (!widget.isWhishList)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(62, 158, 158, 158),
                    child: IconButton(
                      onPressed: () {
                        // wishlist.wishlishedCourse?.add(widget.courseId!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to Wishlist!')),
                        );
                      },
                      icon: const Icon(Icons.bookmark_outline,
                          color: Colors.white),
                    ),
                  ),
                ),
            ],
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xFF126E64),
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'About'),
                Tab(text: 'Lesson'),
                Tab(text: 'Tools'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  AboutTabSection(data: widget.courseId),
                  LessonTabSection(
                    url: widget.courseId?.video,
                  ),
                  ToolsTabSection(
                    index: widget.index,
                  ),
                ],
              ),
            ),
            isDisabled
                ? const DisabledEnrollBottomBar()
                : const EnrollBottomBar()
          ],
        ),
      ),
    );
  }
}

class AboutTabSection extends StatelessWidget {
  final Courses? data;
  const AboutTabSection({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    log('data-unique: data?.description: ${data?.description} ');
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Text(
        data?.description ?? 'Empty',
        // detail.courseData.description ?? '',
      ),
    );
  }
}

class LessonTabSection extends StatelessWidget {
  const LessonTabSection({super.key, this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    final section = Provider.of<CourseViewModel>(context);
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: YoutubePlayer(
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
        controller: YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url ?? '') ?? '',
        ),
      ),
    );
  }
}

class ToolsTabSection extends StatefulWidget {
  const ToolsTabSection({super.key, required this.index});
  final int index;

  @override
  State<ToolsTabSection> createState() => _ToolsTabSectionState();
}

class _ToolsTabSectionState extends State<ToolsTabSection> {
  @override
  void initState() {
    context.read<HomeCubit>().getTests(widget.index, page: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is TestsSuccess) {
            if (state.index + 1 == state.tests.length) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ваш Результат',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.correctAnswers}/${state.tests.length}',
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      state.tests[state.index].question ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.tests[state.index].variants?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: Colors.green,
                      value: state.selectedTests[index] ?? false,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        state.tests[state.index].variants?[index].variant ?? '',
                        style: TextStyle(
                            color: state.selectedTests[index] == null
                                ? Colors.black
                                : state.selectedTests[index] == false
                                    ? Colors.red
                                    : Colors.green),
                      ),
                      onChanged: (val) {
                        if (state.testStatus == TestStatus.NOT_SELECTED) {
                          context.read<HomeCubit>().selectTest(
                                index,
                                code: state
                                    .tests[state.index].variants?[index].code,
                              );
                        }
                      },
                    );
                  },
                ),
                const Spacer(),
                SizedBox(
                  height: 56,
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    child: const Text('Далее'),
                    onPressed: () {
                      context.read<HomeCubit>().getTests(widget.index);
                    },
                  ),
                )
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ReviewsTabSection extends StatefulWidget {
  const ReviewsTabSection({super.key});

  @override
  State<ReviewsTabSection> createState() => _ReviewsTabSectionState();
}

class _ReviewsTabSectionState extends State<ReviewsTabSection> {
  @override
  Widget build(BuildContext context) {
    final review = Provider.of<CourseViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: review.allReview?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return ReviewCard(
                img: review.allReview?[index].user?.avatar ?? '',
                title: review.allReview?[index].user?.firstname ?? '',
                rating: review.allReview?[index].rating ?? 1,
                desc: review.allReview?[index].review ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}
