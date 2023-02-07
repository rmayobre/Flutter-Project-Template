part of '../home_layout.dart';

class OverviewPage extends StatelessWidget {

  const OverviewPage({Key? key}) : super(key: key);

  static const String name = 'Overview';

  static const String path = '/';

  @override
  Widget build(BuildContext context) {
    context.dispatch(ContentEvent.generate(size: 20));
    return StreamBuilder(
      stream: context.stream<ContentBulk>(),
      builder: (BuildContext context, AsyncSnapshot<ContentBulk> snapshot) {
        var contentBulk = snapshot.data?.bulk;
        if (contentBulk != null) {
          return ListDetail(
            panel: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Container(
                alignment: Alignment.center,
                child: const Text('Panel Area'),
              ),
            ),
            listItems: contentBulk.map((content) {
              return TextContentCard.filled(
                body: content.body,
                title: content.title,
              );
            }).toList(),
          );
          // return ListView.builder(
          //   itemCount: contentBulk.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     var content = contentBulk[index];
          //     return TextContentCard.filled(
          //       body: content.body,
          //       title: content.title,
          //     );
          //   },
          // );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}