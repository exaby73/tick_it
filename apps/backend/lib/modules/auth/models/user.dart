// ignore_for_file: unused_element

import 'package:backend/shared/database/timestamps.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superclass/superclass.dart';

part 'user.freezed.dart';
part 'user.g.dart';
part 'user.superclass.dart';

@freezed
class __User with _$_User {
  const factory __User({
    required int id,
    String? name,
    required String email,
    required String password,
  }) = ___User;
}

@Superclass(
  includeJsonSerialization: true,
  fieldAnnotations: {...Timestamps.fieldAnnotations},
  apply: [
    Merge<__User, __User>(),
    ...Timestamps.apply,
  ],
)
typedef User = $User;

@Superclass(
  includeJsonSerialization: true,
  apply: [
    Omit<__User>(fields: {'id'}),
  ],
)
typedef UserInserable = $UserInserable;
