 import 'package:codegen/model/base_model/base_model.dart';
import 'package:codegen/model/source/source_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
@immutable
final class Article extends BaseModel<Article> {
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(
        json,
      );
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  @override
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  Article fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
