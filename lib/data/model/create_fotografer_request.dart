import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';

part 'create_fotografer_request.g.dart';

@JsonSerializable()
class CreateFotograferRequest {
  final String username;
  final String password;
  final String email;
  final String name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'account_number')
  final String? accountNumber;
  @JsonKey(name: 'bank_account')
  final String? bankAccount;
  final String? gear;
  @JsonKey(name: 'fee_per_hour')
  final int? feePerHour;

  CreateFotograferRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.accountNumber,
    this.bankAccount,
    this.gear,
    this.feePerHour,
  });

  factory CreateFotograferRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFotograferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFotograferRequestToJson(this);

  /// Convert UserFotografer entity to CreateFotograferRequest
  /// Note: username, password, and email should be provided separately
  static CreateFotograferRequest fromEntity(
    UserFotografer entity, {
    required String username,
    required String password,
    required String email,
  }) {
    return CreateFotograferRequest(
      username: username,
      password: password,
      email: email,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      accountNumber: entity.accountNumber,
      bankAccount: entity.bankAccount,
      gear: entity.gears,
      feePerHour: entity.feePerHour,
    );
  }

  /// Create a copy with modification
  CreateFotograferRequest copyWith({
    String? username,
    String? password,
    String? email,
    String? name,
    String? phoneNumber,
    String? accountNumber,
    String? bankAccount,
    String? gear,
    int? feePerHour,
  }) {
    return CreateFotograferRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accountNumber: accountNumber ?? this.accountNumber,
      bankAccount: bankAccount ?? this.bankAccount,
      gear: gear ?? this.gear,
      feePerHour: feePerHour ?? this.feePerHour,
    );
  }
}
