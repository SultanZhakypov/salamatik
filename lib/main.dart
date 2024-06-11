import 'package:dimplom/api/dio_generator.dart';
import 'package:dimplom/firebase_options.dart';
import 'package:dimplom/model/course/course_viewmodel.dart';
import 'package:dimplom/screens/course/model_hive/courses_local_model.dart';
import 'package:dimplom/screens/course/model_hive/hive_extension.dart';
import 'package:dimplom/screens/homescreen/data/repository.dart';
import 'package:dimplom/screens/homescreen/presentation/cubit/home_cubit.dart';
import 'package:dimplom/screens/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'model/auth/auth_viewmodel.dart';
import 'model/profile/profile_viewmodel.dart';
import 'model/wishlist/wishlist_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
   if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CoursesLocalModelAdapter());
    }
   if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TestsHiveAdapter());
    }
   if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(VariantsHiveAdapter());
    }
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) =>
              Repository(dio: RepositoryProvider.of<DioSettings>(context)),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            RepositoryProvider.of<Repository>(context),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..animationStyle = EasyLoadingAnimationStyle.scale;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewModel()),
        ChangeNotifierProvider(create: (_) => WishlistViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Edutiv',
        theme: ThemeData(
          primaryColor: const Color(0xFF126E64),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(),
          ),
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          fontFamily: 'Poppins',
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF126E64),
          ),
        ),
        builder: EasyLoading.init(),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forgetPassword': (context) => const ForgetPasswordScreen(),
          '/confirmPasswordReset': (context) =>
              const ConfirmPasswordResetScreen(),
          '/passwordReset': (context) => const PasswordResetScreen(),
          '/passwordResetSuccess': (context) =>
              const PasswordResetSuccessScreen(),
          '/mainpage': (context) => MainPage(),
          '/homeScreen': (context) => const HomeScreen(),
          '/courseScreen': (context) => const CourseScreen(),
          '/myCourse': (context) => const MyCourseScreen(),
          '/detailCourse': (context) => const DetailCourseScreen(index: 0),
          '/learningCourse': (context) => const LearningCourseScreen(),
          '/successCourse': (context) => const SuccessCourseScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/editProfile': (context) => const EditProfileScreen(),
          '/faq': (context) => const FAQScreen(),
          '/formRequest': (context) => const FormRequestScreen(),
          '/certificate': (context) => const CertificateScreen(),
          '/certificateDetail': (context) => const CertificateDetailScreen(),
          '/dataReport': (context) => const DataReportScreen(),
          '/search': (context) => const SearchScreen(),
        },
      ),
    );
  }
}
