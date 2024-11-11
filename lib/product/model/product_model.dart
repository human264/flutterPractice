import 'package:actual/common/model/model_with_id.dart';
import 'package:actual/restaurant/model/restaruant_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  final String name;
  final String detail;

  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  // 이미지 URL
  final String imgUrl;

  // 상품 가격
  final int price;

  // 레스토랑 정보
  final RestaurantModel restaurant;

  ProductModel(
      {required this.id,
      required this.name,
      required this.detail,
      required this.imgUrl,
      required this.price,
      required this.restaurant});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

}
