import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.phone,
      required this.country,
      required this.profilePhotoPath});

  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? phone;
  final String? country;
  final String? profilePhotoPath;

  @override
  List<Object?> get props => [id, name, surname, email, password, phone, country, profilePhotoPath];

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? phone,
    String? country,
    String? profilePhotoPath,
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
    );
  }
}
