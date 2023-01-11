import 'package:flutter/widgets.dart';

@immutable
class Session {

  const Session({
    required this.id,
    this.name,
    this.email,
  });

  final String id;

  final String? name;

  final String? email;
}