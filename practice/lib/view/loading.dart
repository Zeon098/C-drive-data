import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:practice/view/homepage.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    if (isLoading) {
      return loadingAnimation();
    }
    return const MyHomePage(title: 'Jannah Quiz');
  }
}

Widget loadingAnimation() {
  return LoadingAnimationWidget.threeArchedCircle(
    color: Colors.green.shade300,
    size: 100,
  );
}
