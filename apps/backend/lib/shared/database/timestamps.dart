import 'package:superclass/superclass.dart';

final class Timestamps {
  final DateTime createdAt;
  final DateTime updatedAt;

  const Timestamps({
    required this.createdAt,
    required this.updatedAt,
  });

  static const apply = [
    Merge<$PR, Timestamps>(),
  ];
}
