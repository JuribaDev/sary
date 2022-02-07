import 'package:flutter/material.dart';
import 'package:sary/app/modules/item/view/item_form.dart';
import 'package:sary/app/modules/item/view/item_view.dart';
import 'package:sary/app/modules/transaction/view/transaction_form.dart';
import 'package:sary/app/modules/transaction/view/transaction_view.dart';
import 'package:sary/app/routes/app_routes.dart';

import '../modules/transaction_detail/view/transaction_detail_view.dart';

class RouteGenerator {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.ITEM;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case INITIAL:
        return MaterialPageRoute(builder: (_) => const ItemView());
      case Routes.TRANSACTION:
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => TransactionView(
              item: arguments,
            ),
          );
        } else {
          return _404Route();
        }

      case Routes.TRANSACTION_DETAIL:
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => TransactionDetailView(
              transactionDetailView: arguments,
            ),
          );
        } else {
          return _404Route();
        }

      case Routes.ITEM_FORM:
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => ItemFormView(
              isUpdate: arguments['isUpdate'],
              itemId: arguments['itemId'],
            ),
          );
        } else {
          return _404Route();
        }
      case Routes.TRANSACTION_FORM:
        if (arguments is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => TransactionFormView(
              isUpdate: arguments['isUpdate'],
              transId: arguments['transId'],
              itemId: arguments['itemId'],
            ),
          );
        } else {
          return _404Route();
        }

      default:
        // If there is no such named route in the switch statement
        return _404Route();
    }
  }

  // ignore: non_constant_identifier_names
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
