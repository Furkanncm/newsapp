import 'package:codegen/model/base_model/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_model.g.dart';

@JsonSerializable()
@immutable
final class Source extends Equatable implements BaseModel<Source> {
  const Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  final String? id;
  final String? name;

  @override
  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  Source fromJson(Map<String, Object?> json) => _$SourceFromJson(json);

  @override
  List<Object?> get props => [id, name];
  Source copyWith({ValueGetter<String?>? id, ValueGetter<String?>? name}) {
    return Source(id: id != null ? id() : this.id, name: name != null ? name() : this.name);
  }
}
