import 'media_model.dart';
import 'parents/model.dart';

class Slide extends Model {
  int? order;
  String? text;
  String? textRu;
  Media? image;
  String? imageFit;

  Slide({
    this.order,
    this.text,
    this.textRu,
    this.image,
    this.imageFit,
  });

  Slide.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    order = intFromJson(json, 'order');
    text = stringFromJson(json, 'text');
    textRu = stringFromJson(json, 'text_ru');
    image = mediaFromJson(json, 'image');
    imageFit = stringFromJson(json, 'image_fit');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    return data;
  }
}
