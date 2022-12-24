// To parse this JSON data, do
//
//     final genresModel = genresModelFromJson(jsonString);

import 'dart:convert';

GenresModel genresModelFromJson(String str) =>
    GenresModel.fromJson(json.decode(str));

String genresModelToJson(GenresModel data) => json.encode(data.toJson());

class GenresModel {
  GenresModel({
    this.genres,
  });

  final List<Genre>? genres;

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
