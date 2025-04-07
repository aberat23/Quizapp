import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteQuestionPage extends StatefulWidget {
  @override
  _DeleteQuestionPageState createState() => _DeleteQuestionPageState();
}

class _DeleteQuestionPageState extends State<DeleteQuestionPage> {
  final TextEditingController _questionIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteQuestion() async {
    await _firestore.collection('questions').doc(_questionIdController.text).delete();
    _questionIdController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soru Sil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionIdController,
              decoration: InputDecoration(labelText: 'Soru ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deleteQuestion,
              child: Text('Sil'),
            ),
          ],
        ),
      ),
    );
  }
}
