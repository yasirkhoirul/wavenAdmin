import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';

part 'admin_detail_model.g.dart';

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
class AdminDetailResponse {
	final String message;
	final AdminDetailModel data;

	AdminDetailResponse({
		required this.message,
		required this.data,
	});

	factory AdminDetailResponse.fromJson(Map<String, dynamic> json) =>
			_$AdminDetailResponseFromJson(json);

	Map<String, dynamic> toJson() => _$AdminDetailResponseToJson(this);
}

@JsonSerializable()
class AdminDetailModel {
	final String id;
	final String username;
	final String email;
	final String name;
  final String? pw;
	@JsonKey(name: 'phone_number')
	final String? phoneNumber;

	@JsonKey(name: 'is_active')
	final bool isActive;

	@JsonKey(
		name: 'created_at',
		fromJson: _createdAtFromJson,
		toJson: _createdAtToJson,
	)
	final DateTime createdAt;

	AdminDetailModel({
		required this.id,
		required this.username,
		required this.email,
		required this.name,
		required this.phoneNumber,
		required this.isActive,
		required this.createdAt, this.pw,
	});

	Map<String, dynamic> toCreateJson() {
		return {
			'username': username,
			'email': email,
			'name': name,
			'phone_number': phoneNumber,
			'is_active': isActive,
		};
	}

	Map<String, dynamic> toUpdateJson() {
		// Same fields as create for now; backend identifies resource by URL.
		return {
			'username': username,
			'email': email,
			'name': name,
			'phone_number': phoneNumber,
			'is_active': isActive,
		};
	}

  DetailAdmin toEntity(){
    return DetailAdmin(id, username, email, name, phoneNumber, isActive, createdAt);
  }

  factory AdminDetailModel.fromEntity(DetailAdmin data){
    return AdminDetailModel(id: data.id, username: data.username, email: data.email, name: data.name, phoneNumber: data.phoneNumber, isActive: data.isActive, createdAt: DateTime.now(),pw: data.password);
  }

	factory AdminDetailModel.fromJson(Map<String, dynamic> json) =>
			_$AdminDetailModelFromJson(json);

	Map<String, dynamic> toJson() => _$AdminDetailModelToJson(this);
}
