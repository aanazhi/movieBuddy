import 'package:json_annotation/json_annotation.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String code;
  final String creatorId;
  final List<String> participants;
  final List<MovieModel> movies;
  final Map<String, List<String>> swipes;
  final String? matchedMovie;

  RoomModel({
    required this.code,
    required this.creatorId,
    required this.participants,
    required this.movies,
    required this.swipes,
    required this.matchedMovie,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
