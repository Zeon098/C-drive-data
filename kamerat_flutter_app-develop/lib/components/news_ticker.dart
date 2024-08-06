import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class NewsTicker extends StatelessWidget {
  final String text;

  const NewsTicker({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      height: 32.0,
      width: MediaQuery.of(context).size.width,
      child: Marquee(
        text: text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiary,
            ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        velocity: 100.0,
        startPadding: 10.0,
        pauseAfterRound: Duration.zero,
      ),
    );
  }
}
