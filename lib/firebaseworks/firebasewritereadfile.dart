import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: firebasewritereadfile(),
    );
  }
}

class firebasewritereadfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Expense Manger"),
      ),
      body:Center(
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('ExpenseManagerDemo')
                .add({'text': 'Data'});
          },
        ),
      ),
    );
  }
}
