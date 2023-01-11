library pages;

import 'package:framework/page_registry.dart';
import 'package:pages/src/home/home_page.dart';
import 'package:pages/src/login/login_page.dart';

export 'src/error/error_page.dart';

final List<PageDelegate> pageRegistry = [
  SinglePage(
    name: HomePage.name,
    path: HomePage.path,
    builder: (context) => const HomePage(title: 'Flutter Demo Home Page'),
    nestedPages: []
  ),
  SinglePage(
      name: LoginPage.name,
      path: LoginPage.path,
      builder: (context) => LoginPage(),
      nestedPages: []
  ),
];