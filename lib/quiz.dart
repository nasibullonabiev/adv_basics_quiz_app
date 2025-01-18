import 'package:adv_basics_quiz_app/data/questions.dart';
import 'package:adv_basics_quiz_app/questions_screen.dart';
import 'package:adv_basics_quiz_app/results_screen.dart';
import 'package:adv_basics_quiz_app/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> _selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer){
    _selectedAnswers.add(answer);

    if(_selectedAnswers.length == questions.length){
      setState(() {
        activeScreen = 'results-screen';
      });
    }

  }

  void restartQuiz(){
    setState(() {
      _selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if(activeScreen == 'questions-screen'){
      screenWidget =  QuestionsScreen(onSelectAnswer: chooseAnswer,);
    }

    if(activeScreen == 'results-screen'){
      screenWidget = ResultsScreen(chosenAnswers: _selectedAnswers,onRestart: restartQuiz,);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: screenWidget),
      ),
    );
  }
}
