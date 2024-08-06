import 'package:flutter/material.dart';

import 'package:kamerat_flutter_app/components/app_bar.dart';

class HomeWorkImage extends StatelessWidget {
  final String imageUrl;
  final String tutorialTitle;
  const HomeWorkImage(
      {super.key, required this.tutorialTitle, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(imageUrl),
        ),
        Positioned(
            top: 0, left: 0, right: 0, child: MyAppBar(title: tutorialTitle)),
      ]),
    );
  }
}
