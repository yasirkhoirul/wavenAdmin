// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_photo_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadPhotoResultRequest _$UploadPhotoResultRequestFromJson(
  Map<String, dynamic> json,
) => UploadPhotoResultRequest(
  photoResultUrl: json['photo_result_url'] as String,
);

Map<String, dynamic> _$UploadPhotoResultRequestToJson(
  UploadPhotoResultRequest instance,
) => <String, dynamic>{'photo_result_url': instance.photoResultUrl};

UploadEditedPhotoRequest _$UploadEditedPhotoRequestFromJson(
  Map<String, dynamic> json,
) => UploadEditedPhotoRequest(
  editedPhotoUrl: json['edited_photo_url'] as String,
);

Map<String, dynamic> _$UploadEditedPhotoRequestToJson(
  UploadEditedPhotoRequest instance,
) => <String, dynamic>{'edited_photo_url': instance.editedPhotoUrl};

UploadPhotoResponse _$UploadPhotoResponseFromJson(Map<String, dynamic> json) =>
    UploadPhotoResponse(message: json['message'] as String?);

Map<String, dynamic> _$UploadPhotoResponseToJson(
  UploadPhotoResponse instance,
) => <String, dynamic>{'message': instance.message};
