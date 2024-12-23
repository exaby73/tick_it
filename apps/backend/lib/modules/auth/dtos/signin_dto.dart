import 'package:backend/modules/auth/dtos/signup_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'signin_dto.freezed.dart';
part 'signin_dto.g.dart';

@luthor
@freezed
class SigninRequestDto with _$SigninRequestDto {
  const factory SigninRequestDto({
    @isEmail required String email,
    @HasMin(8) required String password,
  }) = _SigninRequestDto;

  factory SigninRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestDtoFromJson(json);
}

typedef SigninResponseDto = SignupResponseDto;
