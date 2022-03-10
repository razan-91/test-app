// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AppBrain appBrain = AppBrain();

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('اختبار'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: ExamApp(),
        ),
      ),
    );
  }
}

class ExamApp extends StatefulWidget {
  const ExamApp({Key? key}) : super(key: key);

  @override
  State<ExamApp> createState() => _ExamAppState();
}

class _ExamAppState extends State<ExamApp> {
  List<Widget> answerResult = [];
  int rightAnswers = 0;

  void checkAnswer(bool whatUserPicked) {
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (whatUserPicked == correctAnswer) {
        rightAnswers++;
        answerResult.add(const Padding(
          padding: EdgeInsets.all(3.0),
          child: Icon(
            Icons.thumb_up,
            color: Colors.green,
          ),
        ));
      } else {
        answerResult.add(const Padding(
          padding: EdgeInsets.all(3.0),
          child: Icon(
            Icons.thumb_down,
            color: Colors.red,
          ),
        ));
      }
      if (appBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "انتهاء الاختبار",
          desc: "لقد أجبت على $rightAnswersأسئلة صحيحة من أصل 4 ",
          buttons: [
            DialogButton(
              child: const Text(
                "ابدأ من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        appBrain.reset();

        answerResult = [];

        rightAnswers = 0;
      } else {
        appBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: answerResult,
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Image.asset(appBrain.getQuestionImage()),
              const SizedBox(height: 20),
              Text(
                appBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              color: Colors.indigo,
              child: const Text(
                'صح',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              color: Colors.deepOrange,
              child: const Text(
                'خطأ',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
