import 'package:flutter/material.dart';
import 'package:treat_yoself/utils/entities/store.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  String firstName;
  String lastName;
  String userName;
  String password;
  String email;
  int zipcode;
  int rewardID;

  UserData(
      {this.firstName,
      this.lastName,
      this.userName,
      this.password,
      this.email,
      this.zipcode,
      this.rewardID});

  factory UserData.fromJson(Map<String, dynamic> data) =>
      _$UserDataFromJson(data);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
