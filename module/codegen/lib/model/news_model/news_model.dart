import 'package:codegen/model/article_model/article_model.dart';
import 'package:codegen/model/base_model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
@immutable
final class News extends BaseModel<News> {
  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  @override
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  News fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
