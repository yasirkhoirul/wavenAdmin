import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';

part 'user_photographer_model.g.dart';

@JsonSerializable()
class UserFotograferListResponse {
  final String message;
  final Metadata? metadata;
  final List<UserPhotographerModel>? data;


  UserFotograferListResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory UserFotograferListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserFotograferListResponseFromJson(json);
  UserFotograferWrap toEntity(){
    return UserFotograferWrap(listData: data?.map((e) => e.toEntity(),).toList()??[],metada: metadata);
  }
  Map<String, dynamic> toJson() => _$UserFotograferListResponseToJson(this);
}


@JsonSerializable()
class UserPhotographerModel {
  final String id;
  final String name;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'account_number')
  final String? accountNumber;

  @JsonKey(name: 'bank_account')
  final String? bankAccount;

  @JsonKey(name: 'fee_per_hour')
  final int? feePerHour;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final String? gears;
  final String? instagram;
  final String? location;

  UserPhotographerModel({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.accountNumber,
    this.bankAccount,
    this.feePerHour,
    this.gears,
    this.instagram,
    this.location, required this.isActive,
  });

  UserFotografer toEntity() {
    return UserFotografer(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      accountNumber: accountNumber,
      bankAccount: bankAccount,
      feePerHour: feePerHour,
      gears: gears,
      instagram: instagram,
      location: location, isActive: isActive,
    );
  }

  factory UserPhotographerModel.fromJson(Map<String, dynamic> json) =>
      _$UserPhotographerModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPhotographerModelToJson(this);
}