import 'page_delegate.dart';

class PageRegistry {

  const PageRegistry({
    required this.loginPage,
    required this.homePage,
    required this.errorPage,
  });

  final PageDelegate loginPage;

  final PageDelegate homePage;

  final PageDelegate errorPage;

}