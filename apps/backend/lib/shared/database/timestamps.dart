import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superclass/superclass.dart';

final class Timestamps {
  final DateTime createdAt;
  final DateTime updatedAt;

  const Timestamps._({
    required this.createdAt,
    required this.updatedAt,
  });

  static const fieldAnnotations = {
    'createdAt': [JsonKey(name: 'created_at', fromJson: timestampFromJson)],
    'updatedAt': [JsonKey(name: 'updated_at', fromJson: timestampFromJson)],
  };

  static const apply = [
    Merge<$PR, Timestamps>(),
  ];
}

DateTime timestampFromJson(dynamic json) {
  if (json is DateTime) return json;

  if (json is String) {
    return DateTime.parse(json);
  }

  throw StateError('Invalid JSON value for Timestamps');
}
