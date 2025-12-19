import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';

part 'user_detial_model.g.dart';

DateTime _createdAtFromJson(String value) {
	final normalized = value.contains('T') ? value : value.replaceFirst(' ', 'T');
	return DateTime.parse(normalized);
}

String _createdAtToJson(DateTime value) {
	String two(int n) => n.toString().padLeft(2, '0');
	return '${value.year}-${two(value.month)}-${two(value.day)} '
			'${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
}

@JsonSerializable()
class UserDetailResponse {
	final String message;
	final UserDetailModel data;

	UserDetailResponse({
		required this.message,
		required this.data,
	});

	factory UserDetailResponse.fromJson(Map<String, dynamic> json) =>
			_$UserDetailResponseFromJson(json);

	Map<String, dynamic> toJson() => _$UserDetailResponseToJson(this);
}

@JsonSerializable()
class UserDetailModel {
	final String id;
	final String username;
	final String email;
	final String name;

	@JsonKey(name: 'phone_number')
	final String? phoneNumber;

	@JsonKey(name: 'university_name')
	final String? universityName;

	@JsonKey(name: 'university_brief_name')
	final String? universityBriefName;

	@JsonKey(
		name: 'created_at',
		fromJson: _createdAtFromJson,
		toJson: _createdAtToJson,
	)
	final DateTime createdAt;

	UserDetailModel({
		required this.id,
		required this.username,
		required this.email,
		required this.name,
		required this.phoneNumber,
		required this.universityName,
		required this.universityBriefName,
		required this.createdAt,
	});

  DetailUser toEntity(){
    return DetailUser(id, username, email, name, phoneNumber, universityName, universityBriefName, createdAt);
  }
	factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
			_$UserDetailModelFromJson(json);

	Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);
}
