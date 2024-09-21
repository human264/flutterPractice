import 'package:actual/common/model/curosr_pagination_model.dart';
import 'package:actual/restaurant/model/restaruant_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken':'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({
    'accessToken':'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });



}
