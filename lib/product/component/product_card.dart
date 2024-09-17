import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'asset/img/food/ddeok_bok_gi.jpg',
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 16.0,),
      Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('떡볶이',
                style: TextStyle(
                  fontSize :18.0
                ),
              ),
              Text('전통 떡볶이의 정석 \n 맛있습니다.',
              style: ,),
              Text('₩10000')
            ],
          )
      )
    ]);
  }
}
