class ReviewsResponse {
  String? _type;
  String? _message;
  List<Review>? _review;

  String? get type => _type;

  String? get message => _message;

  List<Review>? get review => _review;

  ReviewsResponse({String? type, String? message, List<Review>? review}) {
    _type = type;
    _message = message;
    _review = review;
  }

  ReviewsResponse.fromJson(dynamic json) {
    _type = json['type'];
    _message = json['message'];
    if (json['reviews'] != null) {
      _review = [];
      json['reviews'].forEach((v) {
        _review?.add(Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = _type;
    map['message'] = _message;
    if (_review != null) {
      map['reviews'] = _review?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Review {
  String? _id;
  String? _product;
  String? _user;
  String? _review;
  num? _rating;

  String? get id => _id;

  String? get product => _product;

  String? get user => _user;

  String? get review => _review;

  num? get rating => _rating;

  set reviewSetter(String review) => _review = review;

  set ratingSetter(num rating) => _rating = rating;

  Review({
    String? id,
    String? product,
    String? user,
    String? review,
    num? rating,
  }) {
    _id = id;
    _product = product;
    _user = user;
    _review = review;
    _rating = rating;
  }

  Review.fromJson(dynamic json) {
    _id = json['_id'];
    _product = json['product'];
    _user = json['user'];
    _review = json['review'];
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['product'] = _product;
    map['user'] = _user;
    map['review'] = _review;
    map['rating'] = _rating;
    return map;
  }
}
