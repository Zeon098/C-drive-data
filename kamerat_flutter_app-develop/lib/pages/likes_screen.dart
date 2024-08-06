import 'package:flutter/material.dart';

import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/pages/likes.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Meine Vorlieben"),
      body: Likes(),
    );
  }
}
