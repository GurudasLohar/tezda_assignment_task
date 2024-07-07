import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/product_list/domain/model/product_model.dart';
import 'package:tezda_task/features/product_list/presentation/controller/favorite_list_controller.dart';
import 'package:tezda_task/features/product_list/presentation/controller/product_list_controller.dart';
import 'package:tezda_task/features/product_list/presentation/views/product_details_screen.dart';
import 'package:tezda_task/features/product_list/presentation/widgets/app_bar_widget.dart';
import 'package:tezda_task/features/product_list/presentation/widgets/product_list_item.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productListData = ref.watch(productListDataProvider);
    ref.watch(favoriteListProvider);
    return Scaffold(
      appBar: const AppBarWidget(),
      body: productListData.when(
        data: (productListData) {
          List<ProductModel> productList =
              productListData.map((e) => e).toList();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: MediaQuery.of(context).size.width / 550,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                productListItem: productList[index],
                                productList: productList,
                              ),
                            ),
                          );
                        },
                        child: ProductListItem(
                          onTap: productList[index].isFavorite == true
                              ? () {
                                  ref
                                      .read(favoriteListProvider.notifier)
                                      .removeFromFavorite(
                                          productList[index].id);
                                }
                              : () {
                                  ref
                                      .read(favoriteListProvider.notifier)
                                      .addToFavorite(index, productListData);
                                },
                          productListItem: productList[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
        error: (error, s) => Text(
          error.toString(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
