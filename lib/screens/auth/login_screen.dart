import 'dart:developer';

import 'package:dimplom/components/logo.dart';
import 'package:dimplom/model/profile/profile_viewmodel.dart';
import 'package:dimplom/screens/homescreen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/auth/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences loginState;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
    _passwordVisible = false;
  }

  void checkIsLoggedIn() async {
    loginState = await SharedPreferences.getInstance();
    isLoggedIn = loginState.getBool('isLoggedIn') ?? false;

    if (isLoggedIn == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        (route) => false,
      );
    }
  }

  String pass = 'salamat@gmail.com';
  // String pass = '2002';

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AuthViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const buildLoginTextHeader(),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email'),
                  buildEmailField(emailController: emailController),
                  const SizedBox(height: 14),
                  const Text('Password'),
                  TextFormField(
                    onTapOutside: (event) {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                    },
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Обязательное поле';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/forgetPassword'),
                  child: const Text(
                    'Forget password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text('Вход'.toUpperCase()),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'Salamat@gmail.com.com',
                      query: encodeQueryParameters(
                          <String, String>{'subject': 'Request an Account'}),
                    );

                    launchUrl(emailLaunchUri);
                  },
                  child: const Text(
                    'Contact admin',
                    style: TextStyle(color: Color(0xFF126E64)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class buildLoginTextHeader extends StatelessWidget {
  const buildLoginTextHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon_login.jpg',
            width: 200,
            height: 160,
          ),
          const Text(
            'IT-инновации\nот нуля до героя',
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Мир цифровых технологий',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class buildEmailField extends StatelessWidget {
  const buildEmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      controller: emailController,
      validator: (val) {
        log('data-unique: val: $val ');
        if (val!.isEmpty) {
          return 'Обязательное поле';
        } else if (!val.contains('@gmail.com') == true) {
          return 'Неверная почта';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: 'Enter your email',
      ),
    );
  }
}
