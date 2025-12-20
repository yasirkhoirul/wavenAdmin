import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_fotografer.dart';

part 'user_detial_fotografer_model.g.dart';

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
class UserDetailFotograferResponse {
	final String message;
	final UserDetailFotograferModel data;

	UserDetailFotograferResponse({
		required this.message,
		required this.data,
	});

	factory UserDetailFotograferResponse.fromJson(Map<String, dynamic> json) =>
			_$UserDetailFotograferResponseFromJson(json);

	Map<String, dynamic> toJson() => _$UserDetailFotograferResponseToJson(this);
}

@JsonSerializable()
class UserDetailFotograferModel {
	final String id;
	final String username;
	final String email;
	final String name;

	@JsonKey(name: 'phone_number')
	final String? phoneNumber;

	@JsonKey(name: 'account_number')
	final String? accountNumber;

	@JsonKey(name: 'bank_account')
	final String? bankAccount;

	@JsonKey(name: 'is_active')
	final bool isActive;

	final String? gear;

	@JsonKey(name: 'fee_per_hour')
	final int? feePerHour;

	@JsonKey(
		name: 'created_at',
		fromJson: _createdAtFromJson,
		toJson: _createdAtToJson,
	)
	final DateTime createdAt;

	UserDetailFotograferModel({
		required this.id,
		required this.username,
		required this.email,
		required this.name,
		required this.phoneNumber,
		required this.accountNumber,
		required this.bankAccount,
		required this.isActive,
		required this.gear,
		required this.feePerHour,
		required this.createdAt,
	});

	DetailFotografer toEntity() {
		return DetailFotografer(
			id,
			username,
			email,
			name,
			phoneNumber,
			accountNumber,
			bankAccount,
			isActive,
			gear,
			feePerHour,
			createdAt,
		);
	}

	factory UserDetailFotograferModel.fromEntity(DetailFotografer data) {
		return UserDetailFotograferModel(
			id: data.id,
			username: data.username,
			email: data.email,
			name: data.name,
			phoneNumber: data.phoneNumber,
			accountNumber: data.accountNumber,
			bankAccount: data.bankAccount,
			isActive: data.isActive,
			gear: data.gear,
			feePerHour: data.feePerHour,
			createdAt: data.createdAt,
		);
	}

	factory UserDetailFotograferModel.fromJson(Map<String, dynamic> json) =>
			_$UserDetailFotograferModelFromJson(json);

	Map<String, dynamic> toJson() => _$UserDetailFotograferModelToJson(this);
}
