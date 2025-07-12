// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  name: json['name'] as String?,
  code: json['code'] as String?,
  flag: json['flag'] as String?,
  isSelected: json['isSelected'] as bool?,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'name': instance.name,
  'code': instance.code,
  'flag': instance.flag,
  'isSelected': instance.isSelected,
};
