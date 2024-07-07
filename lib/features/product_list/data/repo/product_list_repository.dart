import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:tezda_task/features/product_list/domain/model/product_model.dart';

class ProductListRepository {
  String productUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> getProducts() async {
    Response response = await get(Uri.parse(productUrl));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
final productListProvider = Provider<ProductListRepository>((ref)=>ProductListRepository());