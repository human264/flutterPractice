


import 'package:actual/common/model/curosr_pagination_model.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/product/model/product_model.dart';
import 'package:actual/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ProductStatNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return ProductStatNotifier(repository: repo);
});

class ProductStatNotifier extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStatNotifier({required super.repository});


}