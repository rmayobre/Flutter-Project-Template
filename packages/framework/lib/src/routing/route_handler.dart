import 'package:flutter/widgets.dart';

abstract class RouteHandler {

  RouterConfig<Object> get config;

  void route(BuildContext context, String name, {
    Map<String, String> pathParams,
    Map<String, dynamic> queryParams
  });
}