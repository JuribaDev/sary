import 'package:flutter/material.dart';
import 'package:sary/app/modules/item/view/item_form.dart';
import 'package:sary/app/modules/item/view/item_view.dart';
import 'package:sary/app/modules/transaction/view/transaction_view.dart';
import 'package:sary/app/routes/app_routes.dart';

import '../modules/transaction_detail/view/transaction_detail_view.dart';

class RouteGenerator {
  static const INITIAL = Routes.ITEM;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case INITIAL:
        return MaterialPageRoute(builder: (_) => const ItemView());
      case Routes.TRANSACTION:
        return MaterialPageRoute(
          builder: (_) => const TransactionView(),
        );
      case Routes.TRANSACTION_DETAIL:
        return MaterialPageRoute(
          builder: (_) => const TransactionDetailView(),
        );
      case Routes.ITEM_FORM:
        if (arguments is Map<String,dynamic>) {
          return MaterialPageRoute(
            builder: (_) => ItemFormView(isUpdate: arguments['isUpdate'],itemId: arguments['itemId'],),
          );
        } else {
          return _404Route();
        }

      default:
        // If there is no such named route in the switch statement
        return _404Route();
    }
  }

  static Route<dynamic> _404Route() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error 404'),
        ),
        body: const Center(
          child: Text('Screen not found 404'),
        ),
      );
    });
  }
}
