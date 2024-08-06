import 'package:get/get.dart';
import 'package:practice/model/questions.dart';

class QuestionsController extends GetxController {
  var selectedValues = <int, int>{}.obs;
  var questions = [].obs;

  void fetchQuestions() async {
    var data = await Questions.getData();
    
    questions.value = data;
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    selectedValues[questionIndex] = answerIndex;
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < selectedValues.length; i++) {
      var correctAnswerIndex = questions[i]['answers']
          .indexWhere((answer) => answer['right'] == true) + 1;
      if (selectedValues[i] == correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }
}
