import 'package:floor/floor.dart';

class TmdbTopRatedMovieResponseModel {
  Dates? dates;
  int? page;
  List<TopRated> results;
  int? totalPages;
  int? totalResults;
  String? name;
  String? uuid;

  TmdbTopRatedMovieResponseModel({
    this.dates,
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
    this.name,
    this.uuid
  });

  factory TmdbTopRatedMovieResponseModel.fromJson(Map<String, dynamic> json) => TmdbTopRatedMovieResponseModel(
    name: json["name"] ?? "",
    uuid: json["uuid"] ?? "",
    dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
    page: json["page"],
    results: json["results"] == null ? [] : List<TopRated>.from(json["results"]!.map((x) => TopRated.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "uuid": uuid,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  TmdbTopRatedMovieResponseModel copyWith(
      {String? name, String? uuid, List<TopRated>? results}) {
    return TmdbTopRatedMovieResponseModel(
        name: name ?? this.name,
        results: results ?? this.results,
        uuid: uuid ?? this.uuid
    );
  }
}

class TmdbNowPlayingMovieResponseModel {
  Dates? dates;
  int? page;
  List<NowPlaying> results;
  int? totalPages;
  int? totalResults;
  String? name;
  String? uuid;

  TmdbNowPlayingMovieResponseModel({
    this.dates,
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
    this.name,
    this.uuid
  });

  factory TmdbNowPlayingMovieResponseModel.fromJson(Map<String, dynamic> json) => TmdbNowPlayingMovieResponseModel(
    name: json["name"] ?? "",
    uuid: json["uuid"] ?? "",
    dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
    page: json["page"],
    results: json["results"] == null ? [] : List<NowPlaying>.from(json["results"]!.map((x) => NowPlaying.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "uuid": uuid,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  TmdbNowPlayingMovieResponseModel copyWith(
      {String? name, String? uuid, List<NowPlaying>? results}) {
    return TmdbNowPlayingMovieResponseModel(
        name: name ?? this.name,
        results: results ?? this.results,
        uuid: uuid ?? this.uuid
    );
  }
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
    minimum: json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum": "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
    "minimum": "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
  };
}

@entity
class NowPlaying {
  bool? adult;
  String? backdropPath;
  @primaryKey
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  NowPlaying({
    this.adult,
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": [],
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
@entity
class TopRated {
  bool? adult;
  String? backdropPath;
  @primaryKey
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  TopRated({
    this.adult,
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory TopRated.fromJson(Map<String, dynamic> json) => TopRated(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": [],
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}