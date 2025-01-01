import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

@luthor
@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}
