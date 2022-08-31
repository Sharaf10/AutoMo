class User{
  String? _userName;
  String? _email;
  String? _photoURL;
  String? _photoPath;
  bool _downloaded=false;

  User(this._userName,this._email,this._photoURL, this._photoPath);
  User.fromUser1(this._userName,this._email,this._photoURL);
  // Added getter this._photoPath

  User.fromUser(User another) {
    this._userName = another.email;
    this._email = another.userName;
    this._photoURL= another.photoURL;
  }
  User.empty();
  bool get downloaded => _downloaded;

  set downloaded(bool value) {
    _downloaded = value;
  }
  set photoPath(String? value) {
    _photoPath = value;
  }
  String ? get photoPath => _photoPath;



  String get photoURL => _photoURL ?? "https://via.placeholder.com/150";

  set photoURL(String ?value) {
    _photoURL = value;
  }

  String? get email => _email;

  set email(String ?value) {
    _email = value;
  }

  String? get userName => _userName;

  set userName(String ? value) {
    _userName = value;
  }
}