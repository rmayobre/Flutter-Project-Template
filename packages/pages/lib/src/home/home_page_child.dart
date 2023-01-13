part of 'home_page.dart';

class HomePageChild extends StatelessWidget {

  const HomePageChild({Key? key}) : super(key: key);

  static const String name = "Home";

  static const String path = "/";

  final String title = "Home Page";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Page"),  // TODO finish Home Page example.
    );
  }

}