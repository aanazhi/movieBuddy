import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final dynamic id;
  final String? name;
  final String? description;
  final int? year;
  final PosterModel? poster;
  final List<GenresModel>? genres;
  final RatingModel? rating;

  MovieModel({
    required this.id,
    this.name,
    this.description,
    this.year,
    required this.poster,
    this.genres,
    this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

@JsonSerializable()
class PosterModel {
  final String? url;

  PosterModel({
    this.url,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) =>
      _$PosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}

@JsonSerializable()
class GenresModel {
  final String? name;

  GenresModel({
    this.name,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      _$GenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenresModelToJson(this);
}

@JsonSerializable()
class RatingModel {
  final double? kp;

  RatingModel({
    this.kp,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
