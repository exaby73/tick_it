import 'dart:convert';

extension PrettyPrintMap on Map<String, dynamic> {
  String get pretty {
    return JsonEncoder.withIndent(' ' * 2).convert(_convert(this));
  }

  Map<String, dynamic> _convert(Map<String, dynamic> map) {
    return map.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, value.toIso8601String());
      } else if (value is Map<String, dynamic>) {
        return MapEntry(key, _convert(value));
      } else {
        return MapEntry(key, value);
      }
    });
  }
}
