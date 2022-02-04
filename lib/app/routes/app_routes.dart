
abstract class Routes {
  Routes._();

  static const ITEM = _Paths.ITEM;
  static const TRANSACTION = _Paths.TRANSACTION;
  static const TRANSACTION_DETAIL = _Paths.TRANSACTION_DETAIL;
}

abstract class _Paths {
  static const ITEM = '/item';
  static const TRANSACTION = '/transaction';
  static const TRANSACTION_DETAIL = '/transaction-detail';
}
