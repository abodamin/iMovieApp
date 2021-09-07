// To parse this JSON data, do
//
//     final movieVideos = movieVideosFromJson(jsonString);

import 'dart:convert';

MovieVideos movieVideosFromJson(String str) => MovieVideos.fromJson(json.decode(str));

String movieVideosToJson(MovieVideos data) => json.encode(data.toJson());

class MovieVideos {
  MovieVideos({
    this.id,
    this.results,
  });

  final int id;
  final List<Result> results;

  factory MovieVideos.fromJson(Map<String, dynamic> json) => MovieVideos(
    id: json["id"] == null ? null : json["id"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "results": results == null ? null : List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.name,
    this.key,
    this.publishedAt,
    this.site,
    this.size,
    this.type,
    this.official,
    this.id,
  });

  final String name;
  final String key;
  final DateTime publishedAt;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"] == null ? null : json["name"],
    key: json["key"] == null ? null : json["key"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    site: json["site"] == null ? null : json["site"],
    size: json["size"] == null ? null : json["size"],
    type: json["type"] == null ? null : json["type"],
    official: json["official"] == null ? null : json["official"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "key": key == null ? null : key,
    "published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
    "site": site == null ? null : site,
    "size": size == null ? null : size,
    "type": type == null ? null : type,
    "official": official == null ? null : official,
    "id": id == null ? null : id,
  };
}
