// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  // this name entered based on key of (status, message) return in your api response
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  BaseResponse(this.status, this.message);

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
