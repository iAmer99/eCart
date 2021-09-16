import 'category.dart';

class Product {
  List<String>? _images;
  List<String>? _imagesId;
  num? _price;
  num? _priceAfterDiscount;
  num? _quantity;
  num? _sold;
  bool? _isOutOfStock;
  num? _ratingsAverage;
  int? _ratingsQuantity;
  String? _id;
  String? _mainImage;
  String? _mainImageId;
  String? _name;
  String? _description;
  Category? _category;
  num? _priceDiscount;
  List<String>? _color;
  List<String>? _size;
  Seller? _seller;
  String? _slug;

  List<String>? get images => _images;

  List<String>? get imagesId => _imagesId;

  num? get price => _price;

  num? get priceAfterDiscount => _priceAfterDiscount;

  num? get quantity => _quantity;

  num? get sold => _sold;

  bool? get isOutOfStock => _isOutOfStock;

  num? get ratingsAverage => _ratingsAverage;

  int? get ratingsQuantity => _ratingsQuantity;

  String? get id => _id;

  String? get mainImage => _mainImage;

  String? get mainImageId => _mainImageId;

  String? get name => _name;

  String? get description => _description;

  Category? get category => _category;

  num? get priceDiscount => _priceDiscount;

  List<String>? get color => _color;

  List<String>? get size => _size;

  Seller? get seller => _seller;

  String? get slug => _slug;

  Product({
    List<String>? images,
    List<String>? imagesId,
    num? price,
    num? priceAfterDiscount,
    num? quantity,
    num? sold,
    bool? isOutOfStock,
    num? ratingsAverage,
    int? ratingsQuantity,
    String? id,
    String? mainImage,
    String? mainImageId,
    String? name,
    String? description,
    Category? category,
    num? priceDiscount,
    List<String>? color,
    List<String>? size,
    Seller? seller,
    String? slug,
  }) {
    _images = images;
    _imagesId = imagesId;
    _price = price;
    _priceAfterDiscount = priceAfterDiscount;
    _quantity = quantity;
    _sold = sold;
    _isOutOfStock = isOutOfStock;
    _ratingsAverage = ratingsAverage;
    _ratingsQuantity = ratingsQuantity;
    _id = id;
    _mainImage = mainImage;
    _mainImageId = mainImageId;
    _name = name;
    _description = description;
    _category = category;
    _priceDiscount = priceDiscount;
    _color = color;
    _size = size;
    _seller = seller;
    _slug = slug;
  }

  Product.fromJson(dynamic json) {
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _imagesId = json['imagesId'] != null ? json['imagesId'].cast<String>() : [];
    _price = json['price'];
    _priceAfterDiscount = json['priceAfterDiscount'];
    _quantity = json['quantity'];
    _sold = json['sold'];
    _isOutOfStock = json['isOutOfStock'];
    _ratingsAverage = json['ratingsAverage'];
    _ratingsQuantity = json['ratingsQuantity'];
    _id = json['_id'];
    _mainImage = json['mainImage'];
    _mainImageId = json['mainImageId'];
    _name = json['name'];
    _description = json['description'];
   /* _category =
        json['category'] != null ? Category.fromJson(json['category']) : null; */
    _priceDiscount = json['priceDiscount'];
    _color = json['colors'] != null ? json['colors'].cast<String>() : [];
    _size = json['sizes'] != null ? json['sizes'].cast<String>() : [];
  //  _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['images'] = _images;
    map['imagesId'] = _imagesId;
    map['price'] = _price;
    map['priceAfterDiscount'] = _priceAfterDiscount;
    map['quantity'] = _quantity;
    map['sold'] = _sold;
    map['isOutOfStock'] = _isOutOfStock;
    map['ratingsAverage'] = _ratingsAverage;
    map['ratingsQuantity'] = _ratingsQuantity;
    map['_id'] = _id;
    map['mainImage'] = _mainImage;
    map['mainImageId'] = _mainImageId;
    map['name'] = _name;
    map['description'] = _description;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['priceDiscount'] = _priceDiscount;
    map['colors'] = _color;
    map['sizes'] = _size;
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    map['slug'] = _slug;
    return map;
  }
}

class Seller {
  String? _id;
  String? _name;
  String? _email;
  String? _companyName;
  String? _address;
  String? _phone;
  String? _profileImage;

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get companyName => _companyName;

  String? get address => _address;

  String? get phone => _phone;

  String? get profileImage => _profileImage;

  Seller(
      {String? id,
      String? name,
      String? email,
      String? companyName,
      String? address,
      String? phone,
      String? profileImage}) {
    _id = id;
    _name = name;
    _email = email;
    _companyName = companyName;
    _address = address;
    _phone = phone;
    _profileImage = profileImage;
  }

  Seller.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _companyName = json['companyName'];
    _address = json['address'];
    _phone = json['phone'];
    _profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['companyName'] = _companyName;
    map['address'] = _address;
    map['phone'] = _phone;
    map['profileImage'] = _profileImage;
    return map;
  }
}
