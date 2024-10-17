import 'dart:convert';

class Movie {
  final MovieImage? image;
  final String id;
  final String title;
  final String? type;
  final String? category;
  final int rank;
  final String cast;
  final int? year;
  final String? yearRange;

  Movie({
    this.image,
    required this.id,
    required this.title,
    this.type,
    this.category,
    required this.rank,
    required this.cast,
    this.year,
    this.yearRange,
  });

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        image: json["i"] == null ? null : MovieImage.fromMap(json["i"]),
        id: json["id"] ?? "",
        title: json["l"] ?? "",
        type: json["q"],
        category: json["qid"],
        rank: json["rank"] ?? 0,
        cast: json["s"] ?? "",
        year: json["y"],
        yearRange: json["yr"],
      );

  Map<String, dynamic> toMap() => {
        "i": image?.toMap(),
        "id": id,
        "l": title,
        "q": type,
        "qid": category,
        "rank": rank,
        "s": cast,
        "y": year,
        "yr": yearRange,
      };
}

class MovieImage {
  final int height;
  final String imageUrl;
  final int width;

  MovieImage({
    required this.height,
    required this.imageUrl,
    required this.width,
  });

  factory MovieImage.fromMap(Map<String, dynamic> json) => MovieImage(
        height: json["height"] ?? 0,
        imageUrl: json["imageUrl"] ?? "",
        width: json["width"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "height": height,
        "imageUrl": imageUrl,
        "width": width,
      };
}

class MovieModel {
  final List<Movie> movies;
  final String query;
  final int version;

  MovieModel({
    this.movies = const [],
    this.query = '',
    this.version = 0,
  });

  factory MovieModel.fromJson(String str) =>
      MovieModel.fromMap(json.decode(str));

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        movies: List<Movie>.from(json["d"]?.map((x) => Movie.fromMap(x)) ?? []),
        query: json["q"] ?? "",
        version: json["v"] ?? 0,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "d": List<dynamic>.from(movies.map((x) => x.toMap())),
        "q": query,
        "v": version,
      };
}
