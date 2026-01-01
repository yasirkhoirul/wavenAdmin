// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_batch_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBatchUserRequest _$DeleteBatchUserRequestFromJson(
  Map<String, dynamic> json,
) => DeleteBatchUserRequest(
  ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$DeleteBatchUserRequestToJson(
  DeleteBatchUserRequest instance,
) => <String, dynamic>{'ids': instance.ids};

DeleteBatchUserResponse _$DeleteBatchUserResponseFromJson(
  Map<String, dynamic> json,
) => DeleteBatchUserResponse(message: json['message'] as String);

Map<String, dynamic> _$DeleteBatchUserResponseToJson(
  DeleteBatchUserResponse instance,
) => <String, dynamic>{'message': instance.message};

DeleteUserResponse _$DeleteUserResponseFromJson(Map<String, dynamic> json) =>
    DeleteUserResponse(message: json['message'] as String);

Map<String, dynamic> _$DeleteUserResponseToJson(DeleteUserResponse instance) =>
    <String, dynamic>{'message': instance.message};
