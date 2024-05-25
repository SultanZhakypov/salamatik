import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselHero extends StatelessWidget {
  const CarouselHero({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 130.0,
        autoPlay: true,
        viewportFraction: 0.7,
      ),
      items: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2021/08/learn-coding-online-for-free.png',
                //'assets/banner/edutiv_go.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/banner/edutiv_bootcamp.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/banner/edutiv_insight.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
