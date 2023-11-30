
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sellers/models/order_model.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/widgets/single_order_widget.dart';

class OrderListView extends StatelessWidget {
  final String title;
  const OrderListView({super.key, required this.title});

  List<OrderModel> getCompletedOrder(AppProvider appProvider) {
    if (title == 'Pending') {
      return appProvider.getPendingOrderList;
    } else if (title == 'Completed') {
      return appProvider.getCompletedOrder;
    } else if (title == 'Canceled') {
      return appProvider.getCanceledOrderList;
    } else if (title == 'Delivery') {
      return appProvider.getDeliveryOrderList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('${title} orders'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getCompletedOrder(appProvider).isEmpty
              ? Center(
                  child: Text('${title} list is empty'),
                )
              : ListView.builder(
                  itemCount: getCompletedOrder(appProvider).length,
                  itemBuilder: (context, index) {
                    OrderModel orderModel =
                        getCompletedOrder(appProvider)[index];

                    return SingleOrderWidget(orderModel: orderModel);
                  }),
        ));
  }
}
