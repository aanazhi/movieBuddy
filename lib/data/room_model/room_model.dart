import 'package:json_annotation/json_annotation.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String code;
  final String creatorId;
  final List<String> participants;
  final List<MovieModel> movies;
  final Map<String, Map<String, bool>> swipes;
  final String? matchedMovieId;
  final int currentMovieIndex;

  RoomModel({
    required this.code,
    required this.creatorId,
    required this.participants,
    required this.movies,
    required this.swipes,
    this.matchedMovieId,
    this.currentMovieIndex = 0,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  RoomModel copyWith({
    String? code,
    String? creatorId,
    List<String>? participants,
    List<MovieModel>? movies,
    Map<String, Map<String, bool>>? swipes,
    String? matchedMovieId,
    int? currentMovieIndex,
  }) {
    return RoomModel(
      code: code ?? this.code,
      creatorId: creatorId ?? this.creatorId,
      participants: participants ?? this.participants,
      movies: movies ?? this.movies,
      swipes: swipes ?? this.swipes,
      matchedMovieId: matchedMovieId ?? this.matchedMovieId,
      currentMovieIndex: currentMovieIndex ?? this.currentMovieIndex,
    );
  }
}
