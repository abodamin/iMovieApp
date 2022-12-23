// To parse this JSON data, do
//
//     final movieCastModel = movieCastModelFromJson(jsonString);

import 'dart:convert';

MovieCastModel movieCastModelFromJson(String str) =>
    MovieCastModel.fromJson(json.decode(str));

String movieCastModelToJson(MovieCastModel data) => json.encode(data.toJson());

class MovieCastModel {
  MovieCastModel({
    this.id,
    this.cast,
    this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        id: json["id"] == null ? null : json["id"],
        cast: json["cast"] == null
            ? null
            : List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: json["crew"] == null
            ? null
            : List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cast": cast == null
            ? null
            : List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": crew == null
            ? null
            : List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  final String department;
  final String job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] == null ? null : json["adult"],
        gender: json["gender"] == null ? null : json["gender"],
        id: json["id"] == null ? null : json["id"],
        knownForDepartment: json["known_for_department"] == null
            ? null
            : json["known_for_department"],
        name: json["name"] == null ? null : json["name"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"] == null ? null : json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "gender": gender == null ? null : gender,
        "id": id == null ? null : id,
        "known_for_department":
            knownForDepartment == null ? null : knownForDepartment,
        "name": name == null ? null : name,
        "original_name": originalName == null ? null : originalName,
        "popularity": popularity == null ? null : popularity,
        "profile_path": profilePath == null ? null : profilePath,
        "cast_id": castId == null ? null : castId,
        "character": character == null ? null : character,
        "credit_id": creditId == null ? null : creditId,
        "order": order == null ? null : order,
        "department": department == null ? null : department,
        "job": job == null ? null : job,
      };
}
