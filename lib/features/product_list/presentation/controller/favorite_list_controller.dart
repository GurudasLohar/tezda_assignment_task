import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/product_list/domain/model/product_model.dart';

class FavoriteController extends StateNotifier<List<ProductModel>> {
  FavoriteController() : super([]);

  void addToFavorite(int index, List<ProductModel> data) {
    data[index].isFavorite = true;
    final result = data.where((element) => element.isFavorite == true).toList();
    state = [...result];
  }

  void removeFromFavorite(int id) {
    for (final item in state) {
      if (item.id == id) {
        item.isFavorite = false;
      }
    }
    final result =
        state.where((element) => element.isFavorite == true).toList();
    state = [...result];
  }
}

final favoriteListProvider =
    StateNotifierProvider<FavoriteController, List<ProductModel>>((ref) {
  return FavoriteController();
});
