library pages;

import 'package:framework/page_registry.dart';
import 'package:pages/src/home/home_layout.dart';
import 'package:pages/src/login/login_page.dart';

export 'src/error/error_page.dart';

const String loginPath = LoginPage.path;
const String homePath = OverviewPage.path;

final List<PageDelegate> pageRegistry = [
  LayoutPage(
    builder: (context, child) => HomeLayout(child: child),
    childPages: [
      SinglePage(
        name: OverviewPage.name,
        path: OverviewPage.path,
        builder: (context) => const OverviewPage(),
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
    ],
  ),
  SinglePage(
      name: LoginPage.name,
      path: LoginPage.path,
      builder: (context) => const LoginPage(),
  ),
];