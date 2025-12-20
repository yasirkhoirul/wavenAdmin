import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/user_admin.dart';

part 'user_admin_model.g.dart';

@JsonSerializable()
class UserListResponseAdmin {
  final String message;
  final Metadata? metadata;
  final List<UserModel>? data;

  UserListResponseAdmin({
    required this.message,
    required this.metadata,
    required this.data,
  });

  UserAdminWrapper toWrapper() {
    return UserAdminWrapper(
      metadata: metadata,
      users: data?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  factory UserListResponseAdmin.fromJson(Map<String, dynamic> json) => 
      _$UserListResponseAdminFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserListResponseAdminToJson(this);
}

