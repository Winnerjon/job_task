import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Model with _$Model {
  const factory Model({
    String? language,
    String? firstName,
    String? lastName,
    dynamic tiktokLogin,
    dynamic tiktokPassword,
    dynamic pubgId,
  }) = _Model;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}