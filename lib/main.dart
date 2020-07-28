import 'package:flutter/material.dart';
import 'package:sample/Screens/contact_details.dart';
import 'package:sample/Screens/contact_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      home: NoteList(),
    );
  }
}
