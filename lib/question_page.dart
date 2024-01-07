import 'package:flutter/material.dart';
import 'package:quiz/model/quizz_ques_ans.dart';




class QuizPage extends StatefulWidget {
  QuizPage({Key? key, required this.quizCategory}) : super(key: key);
  final List<QuizzQues> quizCategory;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("cate"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }

  Widget _answerButton(String answer) {
    return ElevatedButton(
      onPressed: () {
        // Logique pour gérer la réponse ici
      },
      child: Text(answer),
    );
  }
}
