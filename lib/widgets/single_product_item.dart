import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/screens/edit_product.dart';
import 'package:sellers/screens/product_details.dart';

class SingleProductItem extends StatefulWidget {
  final int index;
  final ProductModel singleProduct;
  const SingleProductItem({
    super.key,
    required this.singleProduct,
    required this.index,
  });

  @override
  State<SingleProductItem> createState() => _SingleProductItemState();
}

class _SingleProductItemState extends State<SingleProductItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.singleProduct.quantity > 0
          ? Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        Routes.instance.push(
                            widget: ProductDetails(
                              singleProduct: widget.singleProduct,
                            ),
                            context: context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: Image.network(
                              widget.singleProduct.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.singleProduct.name,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          if (widget.singleProduct.discount != 0.0)
                            FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    'Discount: ETB ${widget.singleProduct.discount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${(((widget.singleProduct.price - widget.singleProduct.discount) / (widget.singleProduct.price)) * 100).toStringAsFixed(0)} %  off',
                                    style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          FittedBox(
                            child: Text(
                              'Price: ETB ${widget.singleProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 14,
                                  decoration:
                                      widget.singleProduct.discount != 0.0
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              const Icon(
                                Icons.description,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Text(
                                  '  ${widget.singleProduct.description}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            height: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // right: 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IgnorePointer(
                          ignoring: isLoading,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await appProvider.deleteProductFromFirebase(
                                  widget.singleProduct);
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Routes.instance.push(
                                widget: EditProduct(
                                  productModel: widget.singleProduct,
                                  index: widget.index,
                                ),
                                context: context);
                          },
                          child: Container(
                            color: Colors.blue,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox.fromSize(),
    );
  }
}
