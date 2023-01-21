import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:framework/service.dart';
import 'package:models/content.dart';

class ContentGenerator extends StreamService<ContentEvent, ContentBulk> {
  
  ContentGenerator({this.delay = 0}) {
    _eventController.stream.listen((event) {
      if (event is GenerateContent) {
        _onGenerateContent(event);
      } else if (event is RefreshContent) {
        _onRefreshContent();
      }
    });
  }

  /// Repository's response delay in seconds.
  final int delay;

  final StreamController<ContentBulk> _modelController = StreamController.broadcast();

  final StreamController<ContentEvent> _eventController = StreamController.broadcast();

  ContentBulk? cache;

  @override
  Stream<ContentBulk> get model => _modelController.stream;

  @override
  void emit(ContentEvent event) {
    _eventController.add(event);
  }

  @override
  Future close() async {
    await _eventController.close();
    await _modelController.close();
  }

  void _onGenerateContent(GenerateContent event) {
    var content = cache;
    if (content == null || event.size != content.bulk.length) {
      content = _generateBulkContent(event.size);
    }
    cache = content;
    _modelController.add(content);
  }
  
  void _onRefreshContent() {
    var content = cache;
    if (content != null) {
      content = _generateBulkContent(content.bulk.length);
      cache = content;
      _modelController.add(content);
    }
  }
  
  ContentBulk _generateBulkContent(int size) {
    return ContentBulk(
      List.generate(size, (index) {
        return Content(
          color: faker.randomGenerator.element(Colors.primaries),
          title: 'Card ${index + 1}',
          body: faker.lorem.sentences(7).join(' '),
        );
      }),
    );
  }
}