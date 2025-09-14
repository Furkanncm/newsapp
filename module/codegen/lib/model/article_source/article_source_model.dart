import 'package:codegen/model/base_model/base_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_source_model.g.dart';

@JsonSerializable()
@immutable
final class ArticleSource extends Equatable
    implements BaseModel<ArticleSource> {
  const ArticleSource({this.id, this.name});

  factory ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceFromJson(json);
  final String? id;
  final String? name;

  @override
  Map<String, dynamic> toJson() => _$ArticleSourceToJson(this);

  @override
  ArticleSource fromJson(Map<String, Object?> json) => _$ArticleSourceFromJson(json);

  @override
  List<Object?> get props => [id, name];
  ArticleSource copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
  }) {
    return ArticleSource(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
    );
  }
}
