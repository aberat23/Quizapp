import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soruları Listele'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('questions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var questions = snapshot.data?.docs;
          return ListView.builder(
            itemCount: questions?.length ?? 0,
            itemBuilder: (context, index) {
              var question = questions?[index];
              return ListTile(
                title: Text(question?['question'] ?? ''),
                subtitle: Text('ID: ${question?.id ?? ''}'),
              );
            },
          );
        },
      ),
    );
  }
}
