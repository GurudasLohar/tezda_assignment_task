import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/product_list/data/repo/product_list_repository.dart';
import 'package:tezda_task/features/product_list/domain/model/product_model.dart';

final productListDataProvider = FutureProvider<List<ProductModel>>((ref) async {
  return ref.watch(productListProvider).getProducts();
});