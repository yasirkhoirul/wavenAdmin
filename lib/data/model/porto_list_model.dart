import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/porto_list.dart';

part 'porto_list_model.g.dart';

@JsonSerializable()
class PortoListResponse {
  final String message;
  final PortoMetadata? metadata;
  final List<PortoData> data;

  const PortoListResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PortoListResponse.fromJson(Map<String, dynamic> json) =>
      _$PortoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PortoListResponseToJson(this);

  PortoList toEntity() {
    return PortoList(
      message: message,
      count: metadata?.count??0,
      page: metadata?.page??0,
      limit: metadata?.limit??0,
      portfolios: data.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class PortoMetadata {
  final int count;
  final int page;
  final int limit;

  const PortoMetadata({
    required this.count,
    required this.page,
    required this.limit,
  });

  factory PortoMetadata.fromJson(Map<String, dynamic> json) =>
      _$PortoMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PortoMetadataToJson(this);
}

@JsonSerializable()
class PortoData {
  final String id;
  final String url;

  const PortoData({
    required this.id,
    required this.url,
  });

  factory PortoData.fromJson(Map<String, dynamic> json) =>
      _$PortoDataFromJson(json);

  Map<String, dynamic> toJson() => _$PortoDataToJson(this);

  Portfolio toEntity() {
    return Portfolio(
      id: id,
      url: url,
    );
  }
}
