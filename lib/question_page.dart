import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      print('Sorular yükleniyor');
      QuerySnapshot querySnapshot = await _firestore.collection('questions').get();
      print('Firestore\'dan alınan belgeler: ${querySnapshot.docs}');
      setState(() {
        _questions = querySnapshot.docs;
        _isLoading = false;
      });
      if (_questions.isEmpty) {
        print('Hiç soru bulunamadı.');
      } else {
        print('${_questions.length} soru bulundu.');
      }
    } catch (e) {
      print('Soru yükleme hatası: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkAnswer(int selectedIndex) async {
    if (_questions.isNotEmpty) {
      int correctAnswerIndex = _questions[_currentQuestionIndex]['correct_answer'];
      if (selectedIndex == correctAnswerIndex) {
        setState(() {
          _score++;
        });
      }
      setState(() {
        _currentQuestionIndex++;
      });

      if (_currentQuestionIndex >= _questions.length) {
        User? user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).update({
            'score': _score,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Question Page'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Soru Sayfası'),
        ),
        body: Center(
          child: Text('Soru bulunamadı.'),
        ),
      );
    }

    DocumentSnapshot currentQuestion = _questions[_currentQuestionIndex];
    Map<String, dynamic> questionData = currentQuestion.data() as Map<String, dynamic>;

    if (!currentQuestion.exists || !questionData.containsKey('answers')) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Soru Sayfası'),
        ),
        body: Center(
          child: Text('Geçersiz soru verisi.'),
        ),
      );
    }

    List<dynamic> answers = questionData['answers'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              questionData['question'],
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            ...answers.map((answer) {
              int answerIndex = answers.indexOf(answer);
              return ElevatedButton(
                onPressed: () => _checkAnswer(answerIndex),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
