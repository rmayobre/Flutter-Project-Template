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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Common'),
        ),
        _MultipleChoiceSettingsRow(
          icon: Icons.language,
          title: 'Language',
          currentChoice: _supportedLanguages[0],
          modalBuilder: (BuildContext context) => _TestModal(),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Account'),
        ),
        _InputSettingsRow(
          icon: Icons.phone,
          title: 'Phone Number',
          modalBuilder: (BuildContext context) => _TestModal(),
        ),
        _InputSettingsRow(
          icon: Icons.email,
          title: 'Email',
          modalBuilder: (BuildContext context) => _TestModal(),
        ),
        _InputSettingsRow(
          icon: Icons.logout,
          title: 'Sign Out',
          modalBuilder: (BuildContext context) => _TestModal(),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Security'),
        ),
        _ToggleSettingsRow(
          icon: Icons.fingerprint,
          title: 'Use fingerprint',
          onToggle: (value) {

          },
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

class _InputSettingsRow extends StatelessWidget {

  const _InputSettingsRow({
    this.icon,
    required this.title, 
    required this.modalBuilder,
  });

  final IconData? icon;

  final String title;

  final WidgetBuilder modalBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(context: context, builder: modalBuilder),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (icon != null) Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

typedef OnToggleCallback = void Function(bool value);

class _ToggleSettingsRow extends StatelessWidget {

  const _ToggleSettingsRow({
    this.icon,
    this.current = false,
    required this.title,
    required this.onToggle,
  });

  final IconData? icon;

  final bool current;

  final String title;

  final OnToggleCallback onToggle;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> switchNotifier = ValueNotifier(current);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (icon != null) Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(icon),
          ),
          Text(title),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder(
                valueListenable: switchNotifier,
                builder: (BuildContext context, value, Widget? child) => Switch(
                  value: value,
                  onChanged: (newValue) {
                    switchNotifier.value = newValue;
                    onToggle(newValue);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'This is an incomplete modal!',
            style: TextStyle(
              fontSize: 48,
            ),
          ),
        ),
      ),
    );
  }

}