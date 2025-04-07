import 'package:flutter/material.dart';
import 'question_list_page.dart';
import 'add_question_page.dart';
import 'update_question_page.dart';
import 'delete_question_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yönetici Paneli'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionListPage()),
                );
              },
              child: Text('Soruları Listele'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionPage()),
                );
              },
              child: Text('Soru Ekle'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateQuestionPage()),
                );
              },
              child: Text('Soru Güncelle'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteQuestionPage()),
                );
              },
              child: Text('Soru Sil'),
            ),
          ],
        ),
      ),
    );
  }
}
