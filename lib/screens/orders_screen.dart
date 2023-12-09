import 'package:flutter/material.dart';
import 'package:sellers/screens/completed_order_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final String title;
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(' Orders'),
          bottom: const TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 10, color: Colors.blue)),
            tabs: [
              Tab(
                  child: Text('All',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal))),
              Tab(
                  child: Text('Pending',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal))),
              Tab(
                  child: Text('Delivery',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal))),
              Tab(
                  child: Text('Canceled',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal))),
              Tab(
                  child: Text('Completed',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal))),
            ],
          ),
        ),
        //drawer: const CustomDrawer(),
        body: const TabBarView(
          children: [
            OrderListView(title: 'All'),
            OrderListView(title: 'Pending'),
            OrderListView(title: 'Delivery'),
            OrderListView(title: 'Canceled'),
            OrderListView(title: 'Completed'),
          ],
        ),
      ),
    );
  }
}
