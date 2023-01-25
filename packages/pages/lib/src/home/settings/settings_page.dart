part of '../home_layout.dart';

class SettingsPage extends StatelessWidget {

  const SettingsPage({Key? key}) : super(key: key);

  static const String name = 'Settings';

  static const String path = '/settings';

  static const List<String> _supportedLanguages = [
    'English',
    'Spanish',
    'French',
    'Simplified Chinese',
    'Traditional Chinese',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Common'),
        ),
        _MultipleChoiceSettingsRow(
          icon: Icons.language,
          title: 'Language',
          currentChoice: _supportedLanguages[0],
          modalBuilder: (BuildContext context) => const InputFieldModel(),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Account'),
        ),
        ModalInputRow(
          icon: Icons.phone,
          title: 'Phone Number',
          builder: (BuildContext context) => const InputFieldModel(),
        ),
        ModalInputRow(
          icon: Icons.email,
          title: 'Email',
          builder: (BuildContext context) => const InputFieldModel(),
        ),
        ModalInputRow(
          icon: Icons.logout,
          title: 'Sign Out',
          builder: (BuildContext context) => const InputFieldModel(),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Security'),
        ),
        const ToggleRow(
          icon: Icons.fingerprint,
          title: 'Use fingerprint',
        ),
      ],
    );
  }
}

class _MultipleChoiceSettingsRow extends StatelessWidget {

  const _MultipleChoiceSettingsRow({
    this.icon,
    this.currentChoice,
    required this.title,
    required this.modalBuilder,
  });

  final IconData? icon;

  final String title;

  final String? currentChoice;
  
  final WidgetBuilder modalBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(context: context, builder: modalBuilder),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }


  Widget _buildBody() {
    var current = currentChoice;
    var iconData = icon;
    if (current != null && iconData != null) {
        return _buildBodyWithIconAndCurrent(iconData, current);
    }
    if (current != null) {
      return _buildBodyWithCurrent(current);
    }
    if (iconData != null) {
      return _buildBodyWithIcon(iconData);
    }
    return Text(title);
  }


  Widget _buildBodyWithIcon(IconData iconData) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(icon),
        ),
        Text(title),
      ],
    );
  }


  Widget _buildBodyWithCurrent(String current) {
    return Column(
      children: [
        Text(title),
        Text(current)
      ],
    );
  }

  Widget _buildBodyWithIconAndCurrent(IconData iconData, String current) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(icon),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
            Text(current)
          ],
        ),
      ],
    );
  }
}