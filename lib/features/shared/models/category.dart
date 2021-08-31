class Category {
  String? _id;
  String? _name;
  String? _description;
  String? _image;
  String? _imageId;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  String? get imageId => _imageId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Category({
    String? id,
    String? name,
    String? description,
    String? image,
    String? imageId,
    String? createdAt,
    String? updatedAt}){
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _imageId = imageId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _imageId = json['imageId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['imageId'] = _imageId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}