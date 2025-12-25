import 'package:json_annotation/json_annotation.dart';

part 'update_user_request_model.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  final String username;
  final String email;
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'university_id')
  final String? universityId;
  @JsonKey(name: 'is_active')
  final bool isActive;

  UpdateUserRequest({
    required this.username,
    required this.email,
    required this.name,
    required this.phoneNumber,
    this.universityId,
    required this.isActive,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}

@JsonSerializable()
class UpdateUserResponse {
  final String message;

  UpdateUserResponse({required this.message});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserResponseToJson(this);
}
