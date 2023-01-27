part of '../home_layout.dart';

const String _about = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Elementum tempus egestas sed sed risus pretium. Ut faucibus pulvinar elementum integer. Pretium vulputate sapien nec sagittis aliquam malesuada. Condimentum id venenatis a condimentum vitae sapien. Et magnis dis parturient montes nascetur ridiculus mus mauris. Vehicula ipsum a arcu cursus vitae congue mauris. Velit scelerisque in dictum non consectetur a erat. Aliquam ultrices sagittis orci a scelerisque purus semper eget duis. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat.

Eget sit amet tellus cras adipiscing enim eu turpis. Nunc consequat interdum varius sit amet. Consequat semper viverra nam libero. Est placerat in egestas erat imperdiet sed euismod nisi. Mattis vulputate enim nulla aliquet porttitor lacus luctus. Volutpat blandit aliquam etiam erat velit scelerisque in. Leo vel orci porta non pulvinar neque. In est ante in nibh. Adipiscing enim eu turpis egestas pretium aenean pharetra. Nec feugiat in fermentum posuere urna nec tincidunt praesent semper. Amet est placerat in egestas. Sed tempus urna et pharetra pharetra massa. Aliquet nibh praesent tristique magna sit amet purus gravida.
''';

class AccountPage extends StatelessWidget {

  const AccountPage({Key? key}) : super(key: key);

  static const String name = 'Account';

  static const String path = '/account';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _AccountProfilePicture(),
          _AccountDetailsRow(
            name: 'John Doe', 
            profession: 'Software Engineer',
          ),
          _AboutDescriptionRow(),
        ],
      ),
    );
  }
}

class _AccountProfilePicture extends StatelessWidget {

  const _AccountProfilePicture();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 72,
      backgroundColor: Colors.black12,
      child: Icon(
        Icons.account_circle,
        size: 144,
        color: Colors.black26,
      ),
    );
  }
}

class _AccountDetailsRow extends StatelessWidget {

  const _AccountDetailsRow({
    required this.name, 
    required this.profession,
  });
  
  final String name;
  
  final String profession;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold
            ),
          ),
          Text(profession, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _AboutDescriptionRow extends StatelessWidget {

  const _AboutDescriptionRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold
          ),
        ),
        Text(_about, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}