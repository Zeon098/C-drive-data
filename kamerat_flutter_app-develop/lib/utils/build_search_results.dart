import 'package:flutter/material.dart';

import 'package:kamerat_flutter_app/controllers/search_overlay.controller.dart';
import 'package:kamerat_flutter_app/components/search_results.dart';
import 'package:kamerat_flutter_app/models/search.model.dart';

List<Widget> buildResults(
    SearchResultsModel searchResults, SearchOverlayController controller) {
  List<Widget> results = [];
  if (searchResults.courses.isNotEmpty) {
    results.add(
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Kurse",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(30, 35, 30, 1),
          ),
        ),
      ),
    );
    for (final course in searchResults.courses) {
      results.add(CoursesResult(controller: controller, course: course));
    }
  }

  if (searchResults.seasons.isNotEmpty) {
    results.add(const SizedBox(height: 32.0));
    results.add(
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Staffeln",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(30, 35, 30, 1),
          ),
        ),
      ),
    );
    for (final season in searchResults.seasons) {
      results.add(SeasonsResult(controller: controller, season: season));
    }
  }

  if (searchResults.tutorials.isNotEmpty) {
    results.add(const SizedBox(height: 32.0));
    results.add(
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Episoden",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(30, 35, 30, 1),
          ),
        ),
      ),
    );
    for (final tutorial in searchResults.tutorials) {
      results.add(TutorialsResult(controller: controller, tutorial: tutorial));
    }
  }
  return results;
}
