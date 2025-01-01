import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'signup_dto.freezed.dart';

part 'signup_dto.g.dart';

@luthor
@freezed
class SignupRequestDto with _$SignupRequestDto {
  const factory SignupRequestDto({
    @HasMin(1) required String name,
    @isEmail required String email,
    @HasMin(8) required String password,
  }) = _SignupRequestDto;

  factory SignupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestDtoFromJson(json);
}

