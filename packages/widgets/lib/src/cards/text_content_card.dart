import 'package:flutter/material.dart';

import 'card_type.dart';
import 'elevated_card.dart';
import 'filled_card.dart';
import 'outlined_card.dart';

class TextContentCard extends StatelessWidget {

  const TextContentCard._({
    required this.body,
    required this.title,
    required this.type,
  });

  factory TextContentCard.elevated({
    required String body,
    required String title,
  }) => TextContentCard._(
    body: body,
    title: title,
    type: CardType.elevated,
  );


  factory TextContentCard.filled({
    required String body,
    required String title,
  }) => TextContentCard._(
    body: body,
    title: title,
    type: CardType.filled,
  );

  factory TextContentCard.outlined({
    required String body,
    required String title,
  }) => TextContentCard._(
    body: body,
    title: title,
    type: CardType.outlined,
  );

  final String body;

  final String title;

  final CardType type;

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge,),
        Text(body, style: Theme.of(context).textTheme.bodyLarge,),
      ],
    );
    switch(type) {
      case CardType.elevated:
        return ElevatedCard(child: content);
      case CardType.filled:
        return FilledCard(child: content);
      case CardType.outlined:
        return OutlinedCard(child: content);
    }
  }

}