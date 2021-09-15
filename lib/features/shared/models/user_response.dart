class UserResponse {
  String? _type;
  String? _message;
  User? _user;

  String? get type => _type;

  String? get message => _message;

  User? get user => _user;

  UserResponse({String? type, String? message, User? user}) {
    _type = type;
    _message = message;
    _user = user;
  }

  UserResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  String? _id;
  String? _role;
  bool? _isEmailVerified;
  List<String>? _favoriteProducts;
  String? _name;
  String? _username;
  String? _email;
  String? _companyName;
  String? _address;
  String? _phone;
  String? _profileImage;
  String? _profileImageId;
  String? _discountCode;

  String? get id => _id;

  String? get role => _role;

  bool? get isEmailVerified => _isEmailVerified;

  List<String>? get favoriteProducts => _favoriteProducts;

  String? get name => _name;

  String? get username => _username;

  String? get email => _email;

  String? get companyName => _companyName;

  String? get address => _address;

  String? get phone => _phone;

  String? get profileImage => _profileImage;

  String? get profileImageId => _profileImageId;

  String? get discountCode => _discountCode;

  User({
    String? id,
    String? role,
    bool? isEmailVerified,
    List<String>? favoriteProducts,
    String? name,
    String? username,
    String? email,
    String? companyName,
    String? address,
    String? phone,
    String? profileImage,
    String? profileImageId,
    String? discountCode,
  }) {
    _id = id;
    _role = role;
    _isEmailVerified = isEmailVerified;
    _favoriteProducts = favoriteProducts;
    _name = name;
    _username = username;
    _email = email;
    _companyName = companyName;
    _address = address;
    _phone = phone;
    _profileImage = profileImage;
    _profileImageId = profileImageId;
    _discountCode = discountCode;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _role = json['role'];
    _isEmailVerified = json['isEmailVerified'];
    _favoriteProducts = json['favoriteProducts'] != null
        ? json['favoriteProducts'].cast<String>()
        : [];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _companyName = json['companyName'];
    _address = json['address'];
    _phone = json['phone'];
    _profileImage = json['profileImage'];
    _profileImageId = json['profileImageId'];
    _discountCode = json['discountCode'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['role'] = _role;
    map['isEmailVerified'] = _isEmailVerified;
    map['favoriteProducts'] = _favoriteProducts;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['companyName'] = _companyName;
    map['address'] = _address;
    map['phone'] = _phone;
    map['profileImage'] = _profileImage;
    map['profileImageId'] = _profileImageId;
    map['discountCode'] = _discountCode;
    return map;
  }
}
