import 'package:json_annotation/json_annotation.dart';

part 'delete_batch_user_model.g.dart';

@JsonSerializable()
class DeleteBatchUserRequest {
  final List<String> ids;

  DeleteBatchUserRequest({required this.ids});

  factory DeleteBatchUserRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBatchUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBatchUserRequestToJson(this);
}

@JsonSerializable()
class DeleteBatchUserResponse {
  final String message;

  DeleteBatchUserResponse({required this.message});

  factory DeleteBatchUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteBatchUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteBatchUserResponseToJson(this);
}

@JsonSerializable()
class DeleteUserResponse {
  final String message;

  DeleteUserResponse({required this.message});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteUserResponseToJson(this);
}
