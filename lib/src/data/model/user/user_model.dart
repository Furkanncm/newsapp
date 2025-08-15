import 'package:codegen/model/topic/topic.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.profilePhotoPath,
    required this.topics,
  });

  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? phone;
  final String? country;
  final String? profilePhotoPath;
  final List<Topic>? topics;

  @override
  List<Object?> get props => [
    id,
    name,
    surname,
    email,
    password,
    phone,
    country,
    profilePhotoPath,
    topics,
  ];

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? phone,
    String? country,
    String? profilePhotoPath,
    List<Topic>? topics,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      topics: topics ?? this.topics,
    );
  }
}
