import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String img;
  String title;
  String desc;

  CategoryCard(
      {super.key, required this.img, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: const Color.fromARGB(255, 93, 163, 189),
        elevation: 12,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
