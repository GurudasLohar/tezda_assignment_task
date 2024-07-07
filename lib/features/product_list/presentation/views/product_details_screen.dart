import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/product_list/domain/model/product_model.dart';
import 'package:tezda_task/features/product_list/presentation/controller/favorite_list_controller.dart';
import 'package:tezda_task/features/product_list/presentation/controller/product_list_controller.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel productListItem;
  final List<ProductModel> productList;

  const ProductDetailsScreen(
      {super.key, required this.productListItem, required this.productList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(productListDataProvider);
    ref.watch(favoriteListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    productListItem.image,
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: productListItem.isFavorite == true
                          ? InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                ref
                                    .read(favoriteListProvider.notifier)
                                    .removeFromFavorite(productListItem.id);
                              },
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              ),
                            )
                          : InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                ref
                                    .read(favoriteListProvider.notifier)
                                    .addToFavorite(
                                        productListItem.id - 1, productList);
                              },
                              child: Icon(
                                Icons.favorite_outline_sharp,
                                color: Colors.grey.shade700,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                productListItem.category.capitalize(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                productListItem.title.capitalize(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "\$ ${productListItem.price.toString()}",
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Description:",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                productListItem.description.capitalize(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productListItem.rating.count.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    " Reviews • Overall Rating: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${productListItem.rating.rate} Stars",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: RatingBar.builder(
                  ignoreGestures: false,
                  initialRating: productListItem.rating.rate,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 35,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.redAccent,
                  ),
                  onRatingUpdate: (rating) {
                    //print(rating);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
