
import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/user.dart';
import 'package:wavenadmin/domain/entity/user_list_data.dart';

part 'usermodel.g.dart';

@JsonSerializable()
class UserListResponse {
  final String message;
  final Metadata? metadata;
  final UserDataWrapper? data;

  UserListResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) => 
      _$UserListResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}


@JsonSerializable()
class Metadata {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  Metadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => 
      _$MetadataFromJson(json);
      
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class UserDataWrapper {
  @JsonKey(name: 'total_user')
  final int totalUser;
  
  @JsonKey(name: 'active_user')
  final int activeUser;
  
  @JsonKey(name: 'data')
  final List<UserModel> listUser;

  UserDataWrapper({
    required this.totalUser,
    required this.activeUser,
    required this.listUser,
  });

	List<User> toEntity() {
		return listUser.map((e) => e.toEntity()).toList();
	}

  UserListData toEntityData() {
    return UserListData(totalUser, activeUser, toEntity());
  }

  factory UserDataWrapper.fromJson(Map<String, dynamic> json) => 
      _$UserDataWrapperFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserDataWrapperToJson(this);
}

@JsonSerializable()
class   UserModel {
  final String id;
  final String username;
  final String name;
  final String email;
  
  @JsonKey(name: 'is_active')
  final bool isActive;


  @JsonKey(name: 'phone_number')
  final String? phoneNumber; 

  @JsonKey(name: 'university_name')
  final String? universityName; 
   User toEntity(){
    return User(id, username, name, email, phoneNumber, universityName, isActive);
  }
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.isActive,
    this.phoneNumber,
    this.universityName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
