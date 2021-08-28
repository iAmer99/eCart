
class RegisterResponse {
  String? _type;
  String? _message;
  User? _user;
  Tokens? _tokens;

  String? get type => _type;
  String? get message => _message;
  User? get user => _user;
  Tokens? get tokens => _tokens;

  RegisterResponse({
      String? type, 
      String? message, 
      User? user, 
      Tokens? tokens}){
    _type = type;
    _message = message;
    _user = user;
    _tokens = tokens;
}

  RegisterResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_tokens != null) {
      map['tokens'] = _tokens?.toJson();
    }
    return map;
  }

}

class Tokens {
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Tokens({
      String? accessToken, 
      String? refreshToken}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
}

  Tokens.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    return map;
  }

}

class User {
  String? _name;
  String? _username;
  String? _email;
  String? _password;
  String? _passwordConfirmation;
  String? _role;
  bool? _isEmailVerified;
  String? _address;
  String? _phone;
  String? _companyName;
  String? _profileImage;
  String? _profileImageId;

  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get password => _password;
  String? get passwordConfirmation => _passwordConfirmation;
  String? get role => _role;
  bool? get isEmailVerified => _isEmailVerified;
  String? get address => _address;
  String? get phone => _phone;
  String? get companyName => _companyName;
  String? get profileImage => _profileImage;
  String? get profileImageId => _profileImageId;

  User({
      String? name, 
      String? username, 
      String? email, 
      String? password, 
      String? passwordConfirmation, 
      String? role, 
      bool? isEmailVerified, 
      String? address, 
      String? phone, 
      String? companyName, 
      String? profileImage, 
      String? profileImageId}){
    _name = name;
    _username = username;
    _email = email;
    _password = password;
    _passwordConfirmation = passwordConfirmation;
    _role = role;
    _isEmailVerified = isEmailVerified;
    _address = address;
    _phone = phone;
    _companyName = companyName;
    _profileImage = profileImage;
    _profileImageId = profileImageId;
}

  User.fromJson(dynamic json) {
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _password = json['password'];
    _passwordConfirmation = json['passwordConfirmation'];
    _role = json['role'];
    _isEmailVerified = json['isEmailVerified'];
    _address = json['address'];
    _phone = json['phone'];
    _companyName = json['companyName'];
    _profileImage = json['profileImage'];
    _profileImageId = json['profileImageId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;
    map['passwordConfirmation'] = _passwordConfirmation;
    map['role'] = _role;
    map['isEmailVerified'] = _isEmailVerified;
    map['address'] = _address;
    map['phone'] = _phone;
    map['companyName'] = _companyName;
    map['profileImage'] = _profileImage;
    map['profileImageId'] = _profileImageId;
    return map;
  }

}