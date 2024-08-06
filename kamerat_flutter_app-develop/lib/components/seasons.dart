import 'package:flutter/material.dart';
import 'package:kamerat_flutter_app/components/season_card.dart';

import 'package:kamerat_flutter_app/models/season.model.dart';

class Seasons extends StatelessWidget {
  final List<SeasonModel> seasons;
  const Seasons({super.key, required this.seasons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < seasons.length; i++)
          SeasonCard(
            season: seasons[i],
            index: i,
          ),
      ],
    );
  }
}
