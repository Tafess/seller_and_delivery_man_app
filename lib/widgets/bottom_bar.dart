// import 'package:belkis_marketplace/screens/account_screen.dart';
// import 'package:belkis_marketplace/screens/cart_screen.dart';
// import 'package:belkis_marketplace/screens/favorite_screen.dart';
// import 'package:belkis_marketplace/screens/home/home.dart';
// import 'package:belkis_marketplace/screens/order_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// class CustomBottomBar extends StatefulWidget {
//   const CustomBottomBar({
//     final Key? key,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _CustomBottomBarState createState() => _CustomBottomBarState();
// }

// class _CustomBottomBarState extends State<CustomBottomBar> {
//   final PersistentTabController _controller = PersistentTabController();
//   final bool _hideNavBar = false;

//   List<Widget> _buildScreens() => [
//         const Home(),
//         const CartScreen(),
//         const OrderScreen(),
//         const AccountScreen(),
//         const FavoriteScreen(),

//         //  ProfileScreen(),
//         //OrderScreen(),
//       ];

//   List<PersistentBottomNavBarItem> _navBarsItems() => [
//         PersistentBottomNavBarItem(
//             icon: const Icon(Icons.home),
//             inactiveIcon: const Icon(Icons.home_outlined),
//             title: 'Home',
//             activeColorPrimary: Colors.white,
//             inactiveColorPrimary: Colors.white,
//             inactiveColorSecondary: Colors.purple),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.shopping_cart),
//           inactiveIcon: const Icon(Icons.shopping_cart_outlined),
//           title: 'Cart',
//           activeColorPrimary: Colors.white,
//           inactiveColorPrimary: Colors.white,
//         ),
//         PersistentBottomNavBarItem(
//             icon: const Icon(Icons.circle),
//             inactiveIcon: const Icon(Icons.circle_outlined),
//             title: 'Orders',
//             activeColorPrimary: Colors.white,
//             inactiveColorPrimary: Colors.white),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.person),
//           inactiveIcon: const Icon(Icons.person_2_outlined),
//           title: 'Profile',
//           activeColorPrimary: Colors.white,
//           inactiveColorPrimary: Colors.white,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.settings),
//           title: 'Settings',
//           activeColorPrimary: Colors.white,
//           inactiveColorPrimary: Colors.white,
//         )
//       ];

//   @override
//   Widget build(final BuildContext context) => Scaffold(
//         body: PersistentTabView(
//           context,
//           controller: _controller,
//           screens: _buildScreens(),
//           items: _navBarsItems(),
//           resizeToAvoidBottomInset: true,
//           navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
//               ? 0.0
//               : kBottomNavigationBarHeight,
//           bottomScreenMargin: 0,

//           backgroundColor: Colors.blue.shade400,

//           hideNavigationBar: _hideNavBar,
//           decoration: const NavBarDecoration(colorBehindNavBar: Colors.red),
//           itemAnimationProperties: const ItemAnimationProperties(
//             duration: Duration(milliseconds: 50),
//             curve: Curves.ease,
//           ),
//           screenTransitionAnimation: const ScreenTransitionAnimation(
//             animateTabTransition: true,
//           ),
//           navBarStyle:
//               NavBarStyle.style9, // Choose the nav bar style with this property
//         ),
//       );
// }
