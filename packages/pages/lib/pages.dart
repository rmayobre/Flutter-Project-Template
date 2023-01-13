library pages;

import 'package:framework/page_registry.dart';
import 'package:pages/src/account/account_page.dart';
import 'package:pages/src/home/home_layout.dart';
import 'package:pages/src/login/login_page.dart';
import 'package:pages/src/search/search_page.dart';
import 'package:pages/src/settings/settings_page.dart';

export 'src/error/error_page.dart';

final List<PageDelegate> pageRegistry = [
  LayoutPage(
    builder: (context, child) => HomeLayout(child: child),
    childPages: [
      SinglePage(
        name: HomePage.name,
        path: HomePage.path,
        builder: (context) => const HomePage(),
      ),
      SinglePage(
        name: SearchPage.name,
        path: SearchPage.path,
        builder: (context) => const SearchPage(),
      ),
      SinglePage(
        name: AccountPage.name,
        path: AccountPage.path,
        builder: (context) => const AccountPage(),
      ),
      SinglePage(
        name: SettingsPage.name,
        path: SettingsPage.path,
        builder: (context) => const SettingsPage(),
      )
    ]
  ),
  SinglePage(
      name: LoginPage.name,
      path: LoginPage.path,
      builder: (context) => LoginPage(),
  ),
];