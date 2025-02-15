import 'dart:math';

import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaruant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestarnat() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get('http://$ip/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List>(
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView.separated(
                    itemBuilder: (_, index) {
                      final item =snapshot.data![index];
                      final pItem = RestaurantModel.fromJson(
                         json: item
                      );
                      return RestaurantCard.fromModel(model: pItem);
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: snapshot.data!.length);

                return RestaurantCard(
                    image: Image.asset(
                      'asset/img/food/ddeok_bok_gi.jpg',
                      fit: BoxFit.cover,
                    ),
                    name: '불타는 떡볶이',
                    tags: ['떡볶이', '치즈', ' 매운맛'],
                    ratingsCount: 100,
                    deliveryTime: 15,
                    deliveryFee: 2000,
                    ratings: 4.52);
              },
              future: paginateRestarnat(),
            )),
      ),
    );
  }
}
