import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel extends Equatable implements BaseModel<UserModel> {
  const UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.phone,
    this.country,
    this.profilePhoto,
    this.topics,
    this.savedArticles,
  });

  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? phone;
  final String? country;
  final String? profilePhoto;
  final List<Topic>? topics;
  final List<Article>? savedArticles;

  @override
  List<Object?> get props => [
    id,
    name,
    surname,
    email,
    password,
    phone,
    country,
    profilePhoto,
    topics,
    savedArticles,
  ];

  UserModel copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? phone,
    String? country,
    String? profilePhoto,
    List<Topic>? topics,
    List<Article>? savedArticles,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      topics: topics ?? this.topics,
      savedArticles: savedArticles ?? this.savedArticles,
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
