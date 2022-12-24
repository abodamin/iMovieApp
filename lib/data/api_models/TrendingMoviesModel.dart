// To parse this JSON data, do
//
//     final trendingMoviesModel = trendingMoviesModelFromJson(jsonString);

import 'dart:convert';

TrendingMoviesModel trendingMoviesModelFromJson(String str) =>
    TrendingMoviesModel.fromJson(json.decode(str));

String trendingMoviesModelToJson(TrendingMoviesModel data) =>
    json.encode(data.toJson());

class TrendingMoviesModel {
  TrendingMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  factory TrendingMoviesModel.fromJson(Map<String, dynamic> json) =>
      TrendingMoviesModel(
        page: json["page"] == null ? null : json["page"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        totalResults:
            json["total_results"] == null ? null : json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages == null ? null : totalPages,
        "total_results": totalResults == null ? null : totalResults,
      };
}

class Result {
  Result({
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.voteCount,
    this.adult,
    this.backdropPath,
    this.title,
    this.genreIds,
    this.id,
    this.popularity,
    this.mediaType,
  });

  final String? originalLanguage;
  final String? originalTitle;
  final String? posterPath;
  final bool? video;
  final double? voteAverage;
  final String? overview;
  final DateTime? releaseDate;
  final int? voteCount;
  final bool? adult;
  final String? backdropPath;
  final String? title;
  final List<int>? genreIds;
  final int? id;
  final double? popularity;
  final String? mediaType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        title: json["title"] == null ? null : json["title"],
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        mediaType: json["media_type"] == null ? null : json["media_type"],
      );

  Map<String, dynamic> toJson() => {
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "poster_path": posterPath == null ? null : posterPath,
        "video": video == null ? null : video,
        "vote_average": voteAverage == null ? null : voteAverage,
        "overview": overview == null ? null : overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "vote_count": voteCount == null ? null : voteCount,
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "title": title == null ? null : title,
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id == null ? null : id,
        "popularity": popularity == null ? null : popularity,
        "media_type": mediaType == null ? null : mediaType,
      };
}
