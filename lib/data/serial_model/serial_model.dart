import 'package:json_annotation/json_annotation.dart';

part 'serial_model.g.dart';

@JsonSerializable()
class SerialModel {
  final String name;
  final String? description;
  final int year;
  final PosterModel poster;
  final List<GenresModel> genres;
  final RatingModel rating;

  SerialModel({
    required this.name,
    required this.description,
    required this.year,
    required this.poster,
    required this.genres,
    required this.rating,
  });

  factory SerialModel.fromJson(Map<String, dynamic> json) =>
      _$SerialModelFromJson(json);

  Map<String, dynamic> toJson() => _$SerialModelToJson(this);
}

@JsonSerializable()
class PosterModel {
  final String url;

  PosterModel({
    required this.url,
  });

  factory PosterModel.fromJson(Map<String, dynamic> json) =>
      _$PosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}

@JsonSerializable()
class GenresModel {
  final String name;

  GenresModel({
    required this.name,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      _$GenresModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenresModelToJson(this);
}

@JsonSerializable()
class RatingModel {
  final double kp;

  RatingModel({
    required this.kp,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
