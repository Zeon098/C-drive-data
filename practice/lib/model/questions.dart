import 'dart:convert';

import 'package:http/http.dart';

class Questions {
  late String id;
  late String tag;
  late int difficulty;
  late String content;
  late String answer;

  Questions(
      {required this.id,
      required this.tag,
      required this.difficulty,
      required this.content,
      required this.answer});

  static Future<List> getData() async {
    try {
      Response response = await get(Uri.parse(
          'https://api.jannahquiz.com/v1/player/question/published/'));
      List data= jsonDecode(response.body);
     return data.getRange(0, 10).toList();
       
         
    } catch (e) {
      print('Caught Error: $e');
      return [];
    }
  }
}
