import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sellers/screens/account_screen.dart';
import 'package:sellers/screens/cart_screen.dart';
import 'package:sellers/screens/favorite_screen.dart';
import 'package:sellers/screens/home.dart';
import 'package:sellers/screens/order_screen.dart';
import 'package:sellers/screens/orders_screen.dart';
import 'package:sellers/screens/product_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const HomePage(),
        const ProductView(),
        const OrdersScreen(),
        // const AccountScreen(),
        // const FavoriteScreen(),

        //  ProfileScreen(),
        //OrderScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined, size: 20),
            title: 'Home',
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.deepOrange,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shop_rounded),
          inactiveIcon: const Icon(Icons.shop_outlined, size: 20),
          title: 'Products',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.deepOrange,
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.circle),
            inactiveIcon: const Icon(Icons.circle_outlined, size: 20),
            title: 'Orders',
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.deepOrange),
        //   PersistentBottomNavBarItem(
        //     icon: const Icon(Icons.person),
        //     inactiveIcon: const Icon(Icons.person_2_outlined, size: 20),
        //     title: 'Profile',
        //     activeColorPrimary: Colors.blue,
        //     inactiveColorPrimary: Colors.deepOrange,
        //   ),
        //   PersistentBottomNavBarItem(
        //     icon: const Icon(Icons.settings_applications),
        //     inactiveIcon: Icon(
        //       Icons.settings,
        //       size: 20,
        //     ),
        //     title: 'Settings',
        //     activeColorPrimary: Colors.blue,
        //     inactiveColorPrimary: Colors.deepOrange,
        //   )
        //
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Colors.white,

          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.red),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 0),
            curve: Curves.linear,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle
              .style13, // Choose the nav bar style with this property
        ),
      );
}
