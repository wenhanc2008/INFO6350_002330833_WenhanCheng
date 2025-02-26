import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  List<int> _selectedAnswers = [];
  late Timer _timer;
  int _timeLeft = 60;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer();
  }

  Future<void> _loadQuestions() async {
    final String data = await rootBundle.loadString('assets/quiz_questions.json');
    final List<dynamic> loadedQuestions = json.decode(data);
    setState(() {
      _questions = loadedQuestions..shuffle();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endQuiz();
      }
    });
  }

  void _endQuiz() {
    _timer.cancel();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Time\'s up!'),
        content: Text('Your final score is: $_score'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _score = 0;
                _currentQuestionIndex = 0;
              });
            },
          ),
        ],
      ),
    );
  }

  void _submitAnswer() {
    setState(() {
      _isAnswered = true;
      if (_questions[_currentQuestionIndex]["answer"]
              .contains(_selectedAnswers[0])) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _selectedAnswers.clear();
      _isAnswered = false;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _timer.cancel();
        _showScore();
      }
    });
  }

  void _showScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed!'),
        content: Text('Your final score is: $_score'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _score = 0;
                _currentQuestionIndex = 0;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final questionType = question["type"];
    final options = question["options"];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz App - Time left: $_timeLeft')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question["question"],
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...List.generate(options.length, (index) {
              return RadioListTile<int>(
                title: Text(options[index]),
                value: index,
                groupValue: _selectedAnswers.isEmpty ? -1 : _selectedAnswers[0],
                onChanged: !_isAnswered
                    ? (value) {
                        setState(() {
                          _selectedAnswers = [value!];
                        });
                      }
                    : null,
              );
            }),
            if (questionType == 'multiple_choice_multiple_answers')
              Text("Select all that apply", style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: !_isAnswered ? _submitAnswer : _nextQuestion,
              child: Text(!_isAnswered ? 'Submit' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}