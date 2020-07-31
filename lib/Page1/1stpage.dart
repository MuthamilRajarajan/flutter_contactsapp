
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import "package:path/path.dart";
import 'package:sample/Page1/1stpage.dart';


class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Button Clicked");
        },
        child: Icon(Icons.person_add),
      ),

    );
  }
}


