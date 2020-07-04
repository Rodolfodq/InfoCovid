class Login{
  String _id;
  String _user;
  String _password;


  Login(this._id, this._user, this._password);

  String get id => _id;
  String get user => _user;
  String get password => _password;

  Login.map(dynamic obj){
    this._id = obj['id'];
    this._user = obj['user'];
    this._password = obj['password'];
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['user'] = _user;
    map['password'] = _password;
    return map;
  }

  Login.fromMap(Map<String, dynamic> map, String id){
    this._id = id?? '';
    this._user = map['user'];
    this._password = map["password"];
  }
}