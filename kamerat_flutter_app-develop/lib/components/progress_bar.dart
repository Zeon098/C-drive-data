import 'package:flutter/material.dart';

class CircularInProgressBar extends StatelessWidget {
  final double percentage;
  const CircularInProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 40.0,
      child: CircularProgressIndicator(
        value: percentage,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        color: Theme.of(context).colorScheme.primary,
        strokeWidth: 4.0,
      ),
    );
  }
}

class CircularCompletedBar extends StatelessWidget {
  const CircularCompletedBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/icons/check.png",
      height: 40.0,
      width: 40.0,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

class LinearProgressBar extends StatelessWidget {
  final double percentage;
  const LinearProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: percentage,
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(32.0),
      minHeight: 8.0,
    );
  }
}
