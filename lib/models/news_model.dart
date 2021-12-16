import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

//在pub run build_runner build之前添加
part 'news_model.g.dart';

/*修改model文件后在项目根目录执行
* flutter packages pub run build_runner build
* */
@JsonSerializable()
class NewsModel {
  final List<String> images;
  final String title;
  final String hint;
  final String url;
  final int id;
  final int type;

  const NewsModel(
      this.images, this.title, this.hint, this.url, this.id, this.type);

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class TopNewsModel {
  final String image;
  final String title;
  final String hint;
  final String url;
  final int id;
  final int type;

  const TopNewsModel(
      this.image, this.title, this.hint, this.url, this.id, this.type);

  factory TopNewsModel.fromJson(Map<String, dynamic> json) =>
      _$TopNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopNewsModelToJson(this);
}

@JsonSerializable()
class TodayNewsModel {
  final List<NewsModel> stories;

  @JsonKey(name: "top_stories")
  final List<TopNewsModel> topStories;

  const TodayNewsModel(this.stories, this.topStories);

  factory TodayNewsModel.fromJson(Map<String, dynamic> json) =>
      _$TodayNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodayNewsModelToJson(this);
}

@JsonSerializable()
class DailyNewsModel {
  final String date;
  final List<NewsModel> stories;

  const DailyNewsModel(this.date, this.stories);

  factory DailyNewsModel.fromJson(Map<String, dynamic> json) =>
      _$DailyNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyNewsModelToJson(this);
}

@JsonSerializable()
class NewsDetailModel {
  final String image;
  final String title;
  final String url;
  final int id;
  final int type;
  @JsonKey(name: "image_hue")
  final String imageHue;
  @JsonKey(name: "image_source")
  final String imageSource;
  @JsonKey(name: "share_url")
  final String shareUrl;
  final List<String> js;
  @JsonKey(name: "ga_prefix")
  final String gaPrefix;
  final List<String> css;
  final String body;

  const NewsDetailModel(
      this.image,
      this.title,
      this.url,
      this.id,
      this.type,
      this.imageHue,
      this.imageSource,
      this.shareUrl,
      this.js,
      this.gaPrefix,
      this.css,
      this.body);

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$NewsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDetailModelToJson(this);
}
