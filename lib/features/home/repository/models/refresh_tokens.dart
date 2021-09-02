
class RefreshTokens {
  String? _type;
  String? _message;
  Tokens? _tokens;

  String? get type => _type;
  String? get message => _message;
  Tokens? get tokens => _tokens;

  RefreshTokens({
      String? type, 
      String? message, 
      Tokens? tokens}){
    _type = type;
    _message = message;
    _tokens = tokens;
}

  RefreshTokens.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    _tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
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