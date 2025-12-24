import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_request_model.g.dart';

@JsonSerializable()
class UploadPhotoResultRequest {
  @JsonKey(name: 'photo_result_url')
  final String photoResultUrl;

  UploadPhotoResultRequest({
    required this.photoResultUrl,
  });

  factory UploadPhotoResultRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResultRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoResultRequestToJson(this);
}

@JsonSerializable()
class UploadEditedPhotoRequest {
  @JsonKey(name: 'edited_photo_url')
  final String editedPhotoUrl;

  UploadEditedPhotoRequest({
    required this.editedPhotoUrl,
  });

  factory UploadEditedPhotoRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadEditedPhotoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadEditedPhotoRequestToJson(this);
}

@JsonSerializable()
class UploadPhotoResponse {
  final String? message;

  UploadPhotoResponse({
    this.message,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoResponseToJson(this);
}
