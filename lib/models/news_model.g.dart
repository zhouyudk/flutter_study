// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      json['title'] as String,
      json['hint'] as String,
      json['url'] as String,
      json['id'] as int,
      json['type'] as int,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'images': instance.images,
      'title': instance.title,
      'hint': instance.hint,
      'url': instance.url,
      'id': instance.id,
      'type': instance.type,
    };

TopNewsModel _$TopNewsModelFromJson(Map<String, dynamic> json) => TopNewsModel(
      json['image'] as String,
      json['title'] as String,
      json['hint'] as String,
      json['url'] as String,
      json['id'] as int,
      json['type'] as int,
    );

Map<String, dynamic> _$TopNewsModelToJson(TopNewsModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'hint': instance.hint,
      'url': instance.url,
      'id': instance.id,
      'type': instance.type,
    };

TodayNewsModel _$TodayNewsModelFromJson(Map<String, dynamic> json) =>
    TodayNewsModel(
      (json['stories'] as List<dynamic>)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['top_stories'] as List<dynamic>)
          .map((e) => TopNewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodayNewsModelToJson(TodayNewsModel instance) =>
    <String, dynamic>{
      'stories': instance.stories,
      'top_stories': instance.topStories,
    };

DailyNewsModel _$DailyNewsModelFromJson(Map<String, dynamic> json) =>
    DailyNewsModel(
      json['date'] as String,
      (json['stories'] as List<dynamic>)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyNewsModelToJson(DailyNewsModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'stories': instance.stories,
    };

NewsDetailModel _$NewsDetailModelFromJson(Map<String, dynamic> json) =>
    NewsDetailModel(
      json['image'] as String,
      json['title'] as String,
      json['url'] as String,
      json['id'] as int,
      json['type'] as int,
      json['image_hue'] as String,
      json['image_source'] as String?,
      json['share_url'] as String,
      (json['js'] as List<dynamic>).map((e) => e as String).toList(),
      json['ga_prefix'] as String,
      (json['css'] as List<dynamic>).map((e) => e as String).toList(),
      json['body'] as String,
    );

Map<String, dynamic> _$NewsDetailModelToJson(NewsDetailModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'url': instance.url,
      'id': instance.id,
      'type': instance.type,
      'image_hue': instance.imageHue,
      'image_source': instance.imageSource,
      'share_url': instance.shareUrl,
      'js': instance.js,
      'ga_prefix': instance.gaPrefix,
      'css': instance.css,
      'body': instance.body,
    };
