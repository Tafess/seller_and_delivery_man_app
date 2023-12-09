import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/models/product_model.dart';
import 'package:sellers/providers/app_provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;

  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  ScrollController? _scrollController;
  bool _isScrollDown = false;
  bool _showAppBar = true;

  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollDown) {
          setState(() {
            _isScrollDown = true;
            _showAppBar = false;
          });
        }
      }
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollDown) {
          setState(() {
            _isScrollDown = false;
            _showAppBar = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    // Routes.instance
                    //     .push(widget: const CartScreen(), context: context);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // Routes.instance
                    //     .push(widget: const FavoriteScreen(), context: context);
                  },
                  icon: const Icon(
                    Icons.favorite,
                  ),
                ),
              ],
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 30),
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              widget.singleProduct.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.singleProduct.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.singleProduct.isFavorite =
                        !widget.singleProduct.isFavorite;
                  });
                  if (widget.singleProduct.isFavorite) {
                    appProvider.addToFavoriteproduct(widget.singleProduct);
                    showMessage('Product added to favorites');
                  } else {
                    appProvider.removeFavoriteproduct(widget.singleProduct);
                    showMessage('Product removed from favorites');
                  }
                },
                icon: Icon(
                  appProvider.getFavoriteProductList
                          .contains(widget.singleProduct)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Text(
            widget.singleProduct.description,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            '${widget.singleProduct.quantity.toString()}   items Found',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              if (quantity > 1)
                CupertinoButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: const CircleAvatar(
                    maxRadius: 14,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.remove),
                  ),
                ),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              quantity < widget.singleProduct.quantity
                  ? CupertinoButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const CircleAvatar(
                        maxRadius: 14,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add),
                      ),
                    )
                  : SizedBox.fromSize(),
            ],
          ),
          const SizedBox(height: 50),
          Text('Total price: ${widget.singleProduct.price * quantity}'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  AppProvider appProvider = Provider.of(context, listen: false);
                  ProductModel productModel =
                      widget.singleProduct.copyWith(quantity: quantity);
                  appProvider.addToCartproduct(productModel);
                  showMessage('product added to cart');
                },
                child: const Text('ADD TO CART'),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: PrimaryButton(
                  onPressed: () {
                    ProductModel productModel =
                        widget.singleProduct.copyWith(quantity: quantity);
                    // Routes.instance.push(
                    //     widget: CheckOutScreen(
                    //       singleProduct: productModel,
                    //     ),
                    //     context: context);
                  },
                  title: 'BUY',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}



















// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
// import 'package:sellers/constants/constants.dart';
// import 'package:sellers/constants/primary_button.dart';
// import 'package:sellers/constants/routes.dart';
// import 'package:sellers/models/product_model.dart';
// import 'package:sellers/providers/app_provider.dart';
// import 'package:sellers/screens/cart_screen.dart';
// import 'package:sellers/screens/check_out.dart';


// class ProductDetails extends StatefulWidget {
//   final ProductModel singleProduct;

//   const ProductDetails({Key? key, required this.singleProduct})
//       : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ProductDetailsState createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   int quantity = 1;

//   ScrollController? _scrollController;
//   bool _isScrollDown = false;
//   bool _showAppBar = true;

//   @override
//   void initState() {
//     _scrollController = ScrollController();

//     _scrollController!.addListener(() {
//       if (_scrollController!.position.userScrollDirection ==
//           ScrollDirection.reverse) {
//         if (!_isScrollDown) {
//           setState(() {
//             _isScrollDown = true;
//             _showAppBar = false;
//           });
//         }
//       }
//       if (_scrollController!.position.userScrollDirection ==
//           ScrollDirection.forward) {
//         if (_isScrollDown) {
//           setState(() {
//             _isScrollDown = false;
//             _showAppBar = true;
//           });
//         }
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(
//       context,
//     );

//     return Scaffold(
//       appBar: _showAppBar
//           ? AppBar(
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     Routes.instance
//                         .push(widget: const CartScreen(), context: context);
//                   },
//                   icon: const Icon(Icons.shopping_cart),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut();
//                     // Routes.instance
//                     //     .push(widget: const FavoriteScreen(), context: context);
//                   },
//                   icon: const Icon(
//                     Icons.favorite,
//                   ),
//                 ),
//               ],
//             )
//           : null,
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 30),
//         children: [
//           SizedBox(
//             height: 300,
//             width: double.infinity,
//             child: Image.network(
//               widget.singleProduct.image,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 widget.singleProduct.name,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     widget.singleProduct.isFavorite =
//                         !widget.singleProduct.isFavorite;
//                   });
//                   if (widget.singleProduct.isFavorite) {
//                     appProvider.addToFavoriteproduct(widget.singleProduct);
//                     showMessage('Product added to favorites');
//                   } else {
//                     appProvider.removeFavoriteproduct(widget.singleProduct);
//                     showMessage('Product removed from favorites');
//                   }
//                 },
//                 icon: Icon(
//                   appProvider.getFavoriteProductList
//                           .contains(widget.singleProduct)
//                       ? Icons.favorite
//                       : Icons.favorite_border,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             widget.singleProduct.description!,
//             style: const TextStyle(
//               fontSize: 16.0,
//             ),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               CupertinoButton(
//                 onPressed: () {
//                   if (quantity >= 1) {
//                     setState(() {
//                       quantity--;
//                     });
//                   }
//                 },
//                 padding: EdgeInsets.zero,
//                 child: const CircleAvatar(
//                   maxRadius: 14,
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.red,
//                   child: Icon(Icons.remove),
//                 ),
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Text(
//                 quantity.toString(),
//                 style: const TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               CupertinoButton(
//                 onPressed: () {
//                   setState(() {
//                     quantity++;
//                   });
//                 },
//                 padding: EdgeInsets.zero,
//                 child: const CircleAvatar(
//                   maxRadius: 14,
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.add),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 50),
//           Text('Total price: ${widget.singleProduct.price * quantity}'),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               OutlinedButton(
//                 style: ButtonStyle(
//                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)))),
//                 onPressed: () {
//                   AppProvider appProvider = Provider.of(context, listen: false);
//                   ProductModel productModel =
//                       widget.singleProduct.copyWith(quantity: quantity);
//                   appProvider.addToCartproduct(productModel);
//                   showMessage('product added to cart');
//                 },
//                 child: const Text('ADD TO CART'),
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               SizedBox(
//                 height: 40,
//                 width: 100,
//                 child: PrimaryButton(
//                   onPressed: () {
//                     ProductModel productModel =
//                         widget.singleProduct.copyWith(quantity: quantity);
//                     Routes.instance.push(
//                         widget: CheckOutScreen(
//                           singleProduct: productModel,
//                         ),
//                         context: context);
//                   },
//                   title: 'BUY',
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//         ],
//       ),
//     );
//   }
// }
