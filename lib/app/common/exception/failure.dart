class ApiFailure {
  late String message;
  ApiFailure({required this.message});

  @override
  String toString() => message;
}

class CacheFailure {
  late String message;
  CacheFailure({required this.message});

  @override
  String toString() => message;
}
