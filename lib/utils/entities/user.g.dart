// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    userName: json['userName'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
    zipcode: json['zipcode'] as int,
    rewardID: json['rewardID'] as int,
  );
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'zipcode': instance.zipcode,
      'rewardID': instance.rewardID,
    };
