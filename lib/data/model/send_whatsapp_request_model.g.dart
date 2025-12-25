// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_whatsapp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendWhatsappRequest _$SendWhatsappRequestFromJson(Map<String, dynamic> json) =>
    SendWhatsappRequest(
      target: json['target'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SendWhatsappRequestToJson(
  SendWhatsappRequest instance,
) => <String, dynamic>{'target': instance.target, 'message': instance.message};

SendWhatsappResponse _$SendWhatsappResponseFromJson(
  Map<String, dynamic> json,
) => SendWhatsappResponse(message: json['message'] as String);

Map<String, dynamic> _$SendWhatsappResponseToJson(
  SendWhatsappResponse instance,
) => <String, dynamic>{'message': instance.message};
