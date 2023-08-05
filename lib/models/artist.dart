import 'parents/model.dart';

class Artist extends Model {
  int? id;
  String? code;
  String? name;
  String? imageUrl;

  Artist({
    this.id,
    this.code,
    this.name,
    this.imageUrl,
  });

  Artist.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    code = stringFromJson(json, 'code');
    name = stringFromJson(json, 'name');
    imageUrl = stringFromJson(json, 'imageUrl');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is Artist &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          name == other.name &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      code.hashCode ^
      imageUrl.hashCode ^
      name.hashCode;
}
