import 'package:json_annotation/json_annotation.dart';

part 'send_whatsapp_request_model.g.dart';

@JsonSerializable()
class SendWhatsappRequest {
  final String target;
  final String message;

  SendWhatsappRequest({
    required this.target,
    required this.message,
  });

  factory SendWhatsappRequest.fromJson(Map<String, dynamic> json) =>
      _$SendWhatsappRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendWhatsappRequestToJson(this);
}

@JsonSerializable()
class SendWhatsappResponse {
  final String message;

  SendWhatsappResponse({
    required this.message,
  });

  factory SendWhatsappResponse.fromJson(Map<String, dynamic> json) =>
      _$SendWhatsappResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendWhatsappResponseToJson(this);
}
