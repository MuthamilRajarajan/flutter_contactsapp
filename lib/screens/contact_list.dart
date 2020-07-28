import 'package:flutter/material.dart';
import 'package:sample/Screens/contact_details.dart';
import 'dart:async';
import 'package:sample/models/note.dart';
import 'package:sample/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper= DatabaseHelper();
  List<Note> noteList;

  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(noteList==null){
      noteList= List<Note>();
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Contacts'),
      ),

      body: getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Button clicked');
          navigateToDetail(Note('','',2,''),'Add');
        },

        tooltip: 'Add Contact',

        child: Icon(Icons.person_add),

      ),
    );
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.white30,
              child: Icon(Icons.keyboard_arrow_right),
            ),

            title: Text(this.noteList[position].username, style: titleStyle,),


          ),
        );
      },
    );
  }
  void navigateToDetail(Note note, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

}
