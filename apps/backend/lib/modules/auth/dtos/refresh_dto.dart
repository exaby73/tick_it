import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luthor/luthor.dart';

part 'refresh_dto.freezed.dart';
part 'refresh_dto.g.dart';

@luthor
@freezed
class RefreshRequestDto with _$RefreshRequestDto {
  const factory RefreshRequestDto({
    @HasMin(1) required String refreshToken,
  }) = _RefreshRequestDto;

  factory RefreshRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestDtoFromJson(json);
}
