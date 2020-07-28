import 'package:flutter/material.dart';
import 'package:sample/Screens/contact_list.dart';
import 'dart:async';
import 'package:sample/models/note.dart';
import 'package:sample/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';


class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  NoteDetail(this.note,this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

  static var _priorities = ['Home', 'Office'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contacts'),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[

            // Username Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: usernameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Name Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // Phone Number Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: phoneNumberController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Phone Number Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Phone',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // Residence element
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  style: textStyle,

                  value: 'Office',

                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                    });
                  }
              ),
            ),

            //Country element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: countryController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Country Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Country',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),


            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          _save();
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),


                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
  void moveToLastScreen(){
    Navigator.pop(context,true);
  }

  void _save() async{
    moveToLastScreen();


    int result;
    result= await helper.insertNote(note);


  }
}


