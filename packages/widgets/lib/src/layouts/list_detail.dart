import 'package:flutter/material.dart';

const int _breakpoint = 840;

class ListDetail extends StatelessWidget {
  const ListDetail({
    super.key,
    required this.panel,
    required this.listItems,
  });

  final Widget panel;

  final List<Widget> listItems;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > _breakpoint) {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) => listItems[index],
              ),
            ),
            Expanded(
              flex: 5,
              child: panel,
            ),
          ],
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: _PanelHeaderDelegate(
                panel: panel,
                height: constraints.maxHeight * 0.4
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                  return listItems[index];
                },
                childCount: listItems.length,
              ),
            )
          ],
        );
      }
    });
  }
}

class _PanelHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _PanelHeaderDelegate({
    required this.height,
    required this.panel,
  });

  final double height;

  final Widget panel;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return panel;
  }

  @override
  bool shouldRebuild(covariant _PanelHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
