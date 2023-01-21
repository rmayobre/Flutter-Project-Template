part of '../home_layout.dart';

class SearchPage extends StatelessWidget {

  const SearchPage({Key? key}) : super(key: key);

  static const String name = 'Search';

  static const String path = '/search';

  @override
  Widget build(BuildContext context) {
    context.emit<ContentEvent>(ContentEvent.generate(size: 20));
    final ValueNotifier<String?> inputNotifier = ValueNotifier(null);
    return StreamBuilder(
      stream: context.stream<ContentBulk>(),
      builder: (BuildContext context, AsyncSnapshot<ContentBulk> snapshot) {
        var contentBulk = snapshot.data?.bulk;
        if (contentBulk != null) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBarSliver(
                  onSearch: (value) => inputNotifier.value = value
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) =>
                    _SearchableCard(
                      content: contentBulk[index],
                      inputListenable: inputNotifier,
                    ),
                    childCount: contentBulk.length,
                ),
              ),
            ],
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

class _SearchBarSliver extends SliverPersistentHeaderDelegate {

  _SearchBarSliver({required this.onSearch});

  final ValueChanged<String?> onSearch;

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => maxExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 0.5, color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: inputBorder,
          enabledBorder: inputBorder,
          hintText: 'Search content...',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onFieldSubmitted: onSearch,
      ),
    );
  }
}

class _SearchableCard extends StatelessWidget {

  const _SearchableCard({
    required this.content,
    required this.inputListenable,
  });

  final Content content;

  final ValueListenable<String?> inputListenable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: inputListenable,
      builder: (context, value, child) {
        var input = inputListenable.value;
        if (input == null) {
          return _buildCard(context);
        } else if (content.title.contains(input)) {
          return _buildCard(context);
        } else if (content.body.contains(input)) {
          return _buildCard(context);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      elevation: 0,
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