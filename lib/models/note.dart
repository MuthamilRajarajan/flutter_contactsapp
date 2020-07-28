class Note{

  int _id;
  String _username;
  String _phoneNumber;
  int _residence;
  String _country;

  Note(this._username, [this._phoneNumber,this._residence,this._country]);
  Note.withId(this._id,this._username, [this._phoneNumber,this._residence,this._country]);

  int get id => _id;
  String get username => _username;
  String get phoneNumber => _phoneNumber;
  int get residence => _residence;
  String get country => _country;

  set username(String newUsername) {
    if (newUsername.length <= 255) {
      this._username = newUsername;
    }
  }

  set phoneNumber(String newPhoneNumber) {
    if (newPhoneNumber.length == 10 ) {
      this._phoneNumber = newPhoneNumber;
    }
  }

  set residence(int newResidence) {
    if (newResidence >= 1 && newResidence <= 2) {
      this._residence = newResidence;
    }
  }

  set country(String newCountry) {
    if (newCountry.length <= 255) {
      this._country = newCountry;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Username'] = _username;
    map['PhoneNumber'] = _phoneNumber;
    map['Residence'] = _residence;
    map['Country'] = _country;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['Username'];
    this._phoneNumber = map['PhoneNumber'];
    this._residence = map['Residence'];
    this._country = map['Country'];
  }


}

