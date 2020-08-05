import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import "package:path/path.dart";
import "package:dropdown_formfield/dropdown_formfield.dart";
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasicSql(),
    );
  }
}

class BasicSql extends StatefulWidget {
  @override
  _BasicSqlState createState() => _BasicSqlState();
}

class _BasicSqlState extends State<BasicSql> {

  String _myActivity;
  String _myActivityResult;
  String isOn = "Home";

  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();

  TextEditingController _country = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  BuildContext _buildcontext;
  List<ContactData> contactList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myActivity = '';
    _myActivityResult = '';

    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    _buildcontext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: _name,
                    validator: (String v) {
                      if (v.length < 5) {
                        return "Please give more than 5 letters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'Fullname',
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height:2.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    validator: (String v) {
                      if (v.length < 10) {
                        return "Please give more than 10 numbers";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone',
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height:2.0),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: DropDownFormField(
                    titleText: 'Residence',
                    hintText: 'Please choose one',
                    value: _myActivity,
                    onSaved: (value) {
                      setState(() {
                        _myActivity = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity = value;
                        debugPrint("User Selected $value");


                      });
                    },
                    dataSource: [
                      {
                        "display": "Office",
                        "value": "Office",
                      },
                      {
                        "display": "Home",
                        "value": "Home",
                      },


                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                SizedBox(height:2.0),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _country,
                    validator: (String v) {
                      if (v.length > 47 || v.length == 0) {
                        return "Please give a  valid country name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Country',
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                  ),

                ),

                RaisedButton(
                  onPressed: () {
                    if (_form.currentState.validate()) {
                      print("success");
                      insertData(_name.text, _phone.text,_myActivity, _country.text);
                      _showAlert();
                      _name.clear();
                      _phone.clear();
                      _myActivity;
                      _country.clear();


                    } else {
                      print("error");
                    }
                  },
                  child: new Text("SAVE"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                ),
                FlatButton(
                  color: Colors.red[200],
                  onPressed: (){
                    _showAlert();
                  },
                  child: Text('Saved Contacts'),

                ),
              ],
            ),
          )),
    );
  }

  Database _db;

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), "contacts_database2.db");
    print("path name: " + path);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            phone TEXT,
            residence TEXT,
            country TEXT NOT NULL
            )
          ''',
        );
      },
    );

//    insertData("praveen Kumar", "9090909090");

    getDataFromDb();
  }


  void getDataFromDb() async {
    List<Map> x = await _db.rawQuery("SELECT * FROM contacts");

    contactList = [];

    setState(() {
      x.forEach((element) {
        ContactData contactData =
        ContactData(element["id"], element["name"], element["phone"],element["residence"],element["country"]);
        contactList.add(contactData);
      });
    });
  }

  void insertData(String name, String phoneNumber,String residence, String country) async {
    print(
        "INSERT INTO contacts (name,phone,residence,country) values ('${name.toUpperCase()}','$phoneNumber','$_myActivity','$country')");

    int n = await _db.rawInsert(
        "INSERT INTO contacts (name,phone,residence,country) values ('$name','$phoneNumber','$_myActivity','$country')");
    print(n);

//    List<Map> x = await _db.rawQuery("SELECT * FROM contacts");

    getDataFromDb();
  }


  void _showAlert() {
    Navigator.push(_buildcontext, MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Saved"),
          backgroundColor: Colors.redAccent,
        ),
        body: Form(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
          ...List.generate(
          contactList.length,
                (index) => Card(
                  color: Colors.white30,
                  elevation: 3.0,
                  child: ListTile(
                  contentPadding: EdgeInsets.only(left:5.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: isOn ==  contactList[index].residence ? Icon(Icons.home) : Icon(Icons.business),
                  ),
                  title: Text("${contactList[index].name}"),
                  subtitle: Text("${contactList[index].phoneNumber}- ${contactList[index].country}- ${contactList[index].residence}"),
                  ),

                ),

          ),
            ],
          ),
        ),
      ),


      );
    }));

  }
}

class ContactData {
  int id;
  String name;
  String phoneNumber;
  String residence;
  String country;

  ContactData(this.id, this.name, this.phoneNumber,this.residence,this.country);
}

