import 'package:dimplom/screens/homescreen/data/model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.topJopa, {super.key});
  final HomeModelTopics topJopa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topJopa.title),
      ),
      body: FloatingBottomArea(
        areaContent: SafeArea(
          child: GestureDetector(
            onTap: () async {
              await launchUrl(
                Uri.parse('https://www.learnqa.ru/java_test'),
                mode: LaunchMode.externalApplication,
              );
            },
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
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                topJopa.category,
                style: const TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingBottomArea extends StatelessWidget {
  const FloatingBottomArea({
    super.key,
    required this.child,
    required this.areaContent,
  });
  final Widget child;
  final Widget areaContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Expanded(child: child), areaContent],
    );
  }
}
