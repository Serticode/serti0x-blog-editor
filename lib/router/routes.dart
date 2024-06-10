class RouteNames {
  RouteNames._internal();
  static RouteNames? _instance;

  static RouteNames get instance {
    _instance ??= RouteNames._internal();
    return _instance!;
  }

  final String document = "/document";
}
