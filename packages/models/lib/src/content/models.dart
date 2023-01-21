import 'package:flutter/material.dart';

class Content {

  const Content({
    required this.color,
    required this.title,
    required this.body,
  });

  final Color color;

  final String title;

  final String body;

}

class ContentBulk {

  ContentBulk(this.bulk);

  final List<Content> bulk;
}