import 'package:flutter/material.dart';
import 'package:notesapp/providers/NoteCollection.dart';
import 'package:notesapp/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider.value(
        child: MyApp(),
        value: NoteCollection(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
