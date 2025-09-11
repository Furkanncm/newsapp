import 'package:codegen/model/base_model/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
@immutable
final class Country extends Equatable implements BaseModel<Country> {
  const Country({this.name, this.code, this.phoneCode, this.flag, this.isSelected});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  final String? name;
  final String? code;
  final String? phoneCode;
  final String? flag;
  final bool? isSelected;

  @override
  Country fromJson(Map<String, Object?> json) => Country.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$CountryToJson(this);

  Country copyWith({String? name, String? code, String? phoneCode, String? flag, bool? isSelected}) {
    return Country(
      name: name ?? this.name,
      code: code ?? this.code,
      phoneCode: phoneCode ?? this.phoneCode,
      flag: flag ?? this.flag,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<dynamic> get props => [name, code, phoneCode, flag, isSelected];
}
