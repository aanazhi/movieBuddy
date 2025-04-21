// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      code: json['code'] as String,
      creatorId: json['creatorId'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      movies: (json['movies'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      swipes: (json['swipes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, bool>.from(e as Map)),
      ),
      matchedMovieId: json['matchedMovieId'] as String?,
      currentMovieIndex: (json['currentMovieIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'code': instance.code,
      'creatorId': instance.creatorId,
      'participants': instance.participants,
      'movies': instance.movies,
      'swipes': instance.swipes,
      'matchedMovieId': instance.matchedMovieId,
      'currentMovieIndex': instance.currentMovieIndex,
    };
