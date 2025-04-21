import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/room_model/room_model.dart';

abstract class RoomRepository {
  Stream<RoomModel> watchRoom(String code);
  Future<void> addParticipaint(String code, String userId);
  Future<void> updateSwipes(
      String code, String userId, String movieId, bool isLiked);
  Future<String> createRoom(String creatorId, List<MovieModel> movies);
  Future<void> checkForMatches(String code, String currentMovieId);
  Future<void> setMatchedMovie(String code, String? movieId);
  Future<void> clearAllSwipes(String code);
  Future<void> setCurrentMovieIndex(String code, int index);
}

class RoomRepositoryImpl implements RoomRepository {
  final FirebaseFirestore _firebaseFirestore;

  RoomRepositoryImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<RoomModel> watchRoom(String code) {
    if (code.isEmpty) {
      return const Stream.empty();
    }
    return _firebaseFirestore
        .collection('rooms')
        .doc(code)
        .snapshots()
        .map((snap) => RoomModel.fromJson(snap.data()!));
  }

  @override
  Future<void> addParticipaint(String code, String userId) async {
    await _firebaseFirestore.collection('rooms').doc(code).update({
      'participants': FieldValue.arrayUnion([userId])
    });
  }

  @override
  Future<void> updateSwipes(
      String code, String userId, String movieId, bool isLiked) async {
    final sanitizedId = _sanitizeId(movieId);
    await _firebaseFirestore.collection('rooms').doc(code).update({
      'swipes.$userId.$sanitizedId': isLiked,
    });

    await checkForMatches(code, movieId);
  }

  @override
  Future<String> createRoom(String creatorId, List<MovieModel> movies) async {
    final roomCode = _generateUniqueRoomCode();
    final roomData = {
      'code': roomCode,
      'creatorId': creatorId,
      'movies': movies.map((movie) {
        return {
          'id': movie.id ?? UniqueKey().toString(),
          'name': movie.name,
          'description': movie.description,
          'year': movie.year,
          'poster': movie.poster?.toJson(),
          'genres': movie.genres?.map((genre) => genre.toJson()).toList(),
          'rating': movie.rating?.toJson(),
        };
      }).toList(),
      'participants': [creatorId],
      'swipes': {},
      'matchedMovieId': null,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firebaseFirestore.collection('rooms').doc(roomCode).set(roomData);
    return roomCode;
  }

  @override
  Future<void> checkForMatches(String code, String currentMovieId) async {
    final doc = await _firebaseFirestore.collection('rooms').doc(code).get();
    if (!doc.exists) return;

    final room = RoomModel.fromJson(doc.data()!);

    bool allVoted = room.participants.every((userId) {
      return room.swipes[userId]?.containsKey(_sanitizeId(currentMovieId)) ??
          false;
    });

    if (!allVoted) return;

    bool allLiked = room.participants.every((userId) {
      return room.swipes[userId]?[_sanitizeId(currentMovieId)] == true;
    });

    if (allLiked) {
      await setMatchedMovie(code, currentMovieId); 
    } else {
      await _firebaseFirestore.collection('rooms').doc(code).update({
        'currentMovieIndex': FieldValue.increment(1),
      });
    }
  }

  String _sanitizeId(String id) {
    return id.replaceAll(RegExp(r'[~*/\[\]]'), '_');
  }

  @override
  Future<void> clearAllSwipes(String code) async {
    await _firebaseFirestore.collection('rooms').doc(code).update({
      'swipes': {},
    });
  }

  @override
  Future<void> setCurrentMovieIndex(String code, int index) async {
    await _firebaseFirestore.collection('rooms').doc(code).update({
      'currentMovieIndex': index,
    });
  }

  @override
  Future<void> setMatchedMovie(String code, String? movieId) async {
    await _firebaseFirestore.collection('rooms').doc(code).update({
      'matchedMovieId': movieId,
    });
  }

  String _generateUniqueRoomCode() {
    const length = 6;
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}
