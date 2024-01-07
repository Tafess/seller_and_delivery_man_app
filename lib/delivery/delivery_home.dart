// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers/constants/custom_text.dart';
import 'package:sellers/screens/orders_screen.dart';
import 'package:sellers/widgets/custom_drawer.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
        //OrdersScreen();
        Scaffold(
      appBar: AppBar(
        title: text(title: 'Delivery HomePage'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: text(title: 'Delivery home'),
      ),
    );
  }
}
