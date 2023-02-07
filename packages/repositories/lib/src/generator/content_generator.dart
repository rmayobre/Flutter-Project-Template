import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:framework/repositories.dart';
import 'package:models/content.dart';

class ContentGenerator extends StreamRepository<ContentEvent, ContentBulk> {
  ContentGenerator(super.dispatcher, {this.delay = 0});

  /// Repository's response delay in seconds.
  final int delay;

  final StreamController<ContentBulk> _modelController =
      StreamController.broadcast();

  ContentBulk? cache;

  @override
  Stream<ContentBulk> get model => _modelController.stream;

  @override
  void onEvent(ContentEvent event) async {
    if (event is GenerateContent) {
      await _onGenerateContent(event);
    } else if (event is RefreshContent) {
      await _onRefreshContent();
    }
  }

  @override
  Future close() async {
    await _modelController.close();
  }

  Future<void> _onGenerateContent(GenerateContent event) async {
    var content = cache;
    if (content == null || event.size != content.bulk.length) {
      content = await _generateBulkContent(event.size);
    }
    cache = content;
    _modelController.add(content);
  }

  Future<void> _onRefreshContent() async {
    var content = cache;
    if (content != null) {
      content = await _generateBulkContent(content.bulk.length);
      cache = content;
      _modelController.add(content);
    }
  }

  Future<ContentBulk> _generateBulkContent(int size) {
    return Future.delayed(Duration(seconds: delay), () {
      return ContentBulk(
        List.generate(size, (index) {
          return Content(
            color: faker.randomGenerator.element(Colors.primaries),
            title: 'Card ${index + 1}',
            body: faker.lorem.sentences(7).join(' '),
          );
        }),
      );
    });
  }
}
