import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/controller/questions_controller.dart';



class Questionspage extends StatelessWidget {

  Questionspage({super.key});

  final QuestionsController controller = Get.put(QuestionsController());

  @override
  Widget build(BuildContext context) {
    controller.fetchQuestions();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Questions'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_high.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (controller.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.questions.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 5,
                        borderOnForeground: true,
                        color: Colors.green[100],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${controller.questions[i]["content"]}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...(controller.questions[i]['answers']).map(
                              (answer) {
                                int answerIndex = controller.questions[i]['answers']
                                        .indexOf(answer) +
                                    1;
                                return Row(
                                  children: [
                                    Obx(() {
                                      return RadioMenuButton(
                                        value: answerIndex,
                                        groupValue: controller.selectedValues[i],
                                        onChanged: (value) {
                                          controller.selectAnswer(i, value as int);
                                        },
                                        child: Text('${answer["content"]}'),
                                      );
                                    }),
                                  ],
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    int score = controller.calculateScore();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Your score'),
                          content: Text('You scored $score out of ${controller.questions.length}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Submit',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}