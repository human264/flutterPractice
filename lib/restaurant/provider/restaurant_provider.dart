import 'package:actual/common/model/curosr_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/restaurant/model/restaruant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);
  return notifier;
});

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {

  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    if (state is! CursorPagination) {
      await this.paginate();
    }
    if (state is! CursorPagination) {
      return;
    }
    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    if (pState.data
        .where((e) => e.id == id)
        .isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[...pState.data, resp],
      );
    } else {
      state = pState.copyWith(
        data: pState.data.map<RestaurantModel>(
              (e) => e.id == id ? resp : e,
        ).toList(),
      );
    }
  }
}
