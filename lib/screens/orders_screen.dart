import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/screens/order_list.dart';
import 'package:sellers/widgets/custom_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
          actions: const [
            Expanded(
                child:
                    OrderCountIndicator(title: 'All', color: Colors.black54)),
            Expanded(
                child: OrderCountIndicator(
                    title: 'Pending', color: Colors.orange)),
            Expanded(
                child:
                    OrderCountIndicator(title: 'Delivery', color: Colors.blue)),
            // Expanded(
            //     child:
            //         OrderCountIndicator(title: 'Canceled', color: Colors.red)),
            Expanded(
                child: OrderCountIndicator(
                    title: 'Completed', color: Colors.green)),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 10, color: Colors.blue)),
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                child: Text('All',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal)),
              ),
              Tab(
                child: Text('Pending',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal)),
              ),
              Tab(
                child: Text('Delivery',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal)),
              ),
              // Tab(
              //   child: Text('Canceled',
              //       style: TextStyle(
              //           color: Colors.black, fontWeight: FontWeight.normal)),
              // ),
              Tab(
                child: Text('Completed',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: const TabBarView(
          children: [
            OrderListView(title: 'All'),
            OrderListView(title: 'Pending'),
            OrderListView(title: 'Delivery'),
            // OrderListView(title: 'Canceled'),
            OrderListView(title: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class OrderCountIndicator extends StatelessWidget {
  final String title;
  final Color color;

  const OrderCountIndicator(
      {Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    int orderCount = getOrderCount(appProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: color,
              radius: 50,
              child: FittedBox(
                child: Text(
                  '$orderCount',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // Text(
          //   title,
          //   style: const TextStyle(color: Colors.black),
          // ),
        ],
      ),
    );
  }

  int getOrderCount(AppProvider appProvider) {
    switch (title) {
      case 'All':
        return appProvider.getAllOrderList.length;
      case 'Pending':
        return appProvider.getPendingOrderList.length;
      case 'Completed':
        return appProvider.getCompletedOrder.length;
      // case 'Canceled':
      //   return appProvider.getCanceledOrderList.length;
      case 'Delivery':
        return appProvider.getDeliveryOrderList.length;
      default:
        return 0;
    }
  }
}
