import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/constants/top_titles.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/widgets/add_product.dart';
import 'package:sellers/widgets/single_product_item.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('products'),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: AddProduct(), context: context);
            },
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopTitles(
                title: 'Products',
                subtitle: appProvider.getProducts.length.toString()),
            GridView.builder(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                shrinkWrap: true,
                primary: false,
                itemCount: appProvider.getProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2),
                itemBuilder: (ctx, index) {
                  ProductModel singleProduct = appProvider.getProducts[index];
                  return SingleProductItem(
                      singleProduct: singleProduct, index: index);
                }),
          ],
        ),
      ),
    );
  }
}
