import 'package:flutter/material.dart';

class UpdateQuestionPage extends StatefulWidget {
  @override
  _UpdateQuestionPageState createState() => _UpdateQuestionPageState();
}

class _UpdateQuestionPageState extends State<UpdateQuestionPage> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soru Güncelle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Soru'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Soru güncelleme işlemi
              },
              child: Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
