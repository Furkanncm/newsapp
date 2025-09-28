import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
final class UserModel extends Equatable implements BaseModel<UserModel> {
  const UserModel({
    this.id,
    this.username,
    this.name,
    this.gender,
    this.email,
    this.phone,
    this.bio,
    this.isSkipped,
    this.isPhoneNumberVerified,
    this.isEmailVerified,
    this.country,
    this.profilePhoto,
    this.website,
    this.topics,
  });

  final String? id;
  final String? username;
  final String? name;
  final String? gender;
  final String? email;
  final String? phone;
  final String? bio;
  final bool? isSkipped;
  final bool? isPhoneNumberVerified;
  final bool? isEmailVerified;
  final String? country;
  final String? profilePhoto;
  final String? website;
  final List<Topic>? topics;

  @override
  List<Object?> get props => [
    id,
    username,
    name,
    email,
    gender,
    phone,
    bio,
    isSkipped,
    isPhoneNumberVerified,
    isEmailVerified,
    country,
    profilePhoto,
    website,
    topics,
  ];

  UserModel copyWith({
    String? id,
    String? username,
    String? name,
    String? gender,
    String? email,
    String? phone,
    String? bio,
    bool? isSkipped,
    bool? isPhoneNumberVerified,
    bool? isEmailVerified,
    String? country,
    String? profilePhoto,
    String? website,
    List<Topic>? topics,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      isSkipped: isSkipped ?? this.isSkipped,
      isPhoneNumberVerified: isPhoneNumberVerified ?? this.isPhoneNumberVerified,
      isEmailVerified:isEmailVerified??this.isEmailVerified,
      country: country ?? this.country,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      website: website ?? this.website,
      topics: topics ?? this.topics,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  UserModel fromJson(Map<String, Object?> json) => UserModel.fromJson(json);

  static UserModel fromFirebaseUser(User? user) {
    if (user == null) return UserModel();

    return UserModel(

      id: user.uid,
      email: user.email,
      name: user.displayName,
      profilePhoto: user.photoURL,
      phone: user.phoneNumber,
    );
  }
}
