part of '../home_layout.dart';

class OverviewPage extends StatelessWidget {

  const OverviewPage({Key? key}) : super(key: key);

  static const String name = 'Overview';

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    context.emit<ContentEvent>(ContentEvent.generate(size: 20));
    return StreamBuilder(
      stream: context.stream<ContentBulk>(),
      builder: (BuildContext context, AsyncSnapshot<ContentBulk> snapshot) {
        var contentBulk = snapshot.data?.bulk;
        if (contentBulk != null) {
          return ListView.builder(
            itemCount: contentBulk.length,
            itemBuilder: (BuildContext context, int index) {
              return _OverviewCard(content: contentBulk[index]);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {

  const _OverviewCard({required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: content.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              content.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              content.body,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}