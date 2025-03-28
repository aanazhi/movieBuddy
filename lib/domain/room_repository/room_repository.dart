import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviebuddy/data/room_model/room_model.dart';

abstract class RoomRepository {
  Stream<RoomModel> watchRoom(String code);
}

class RoomRepositoryImpl implements RoomRepository {
  final FirebaseFirestore _firebaseFirestore;

  RoomRepositoryImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<RoomModel> watchRoom(String code) {
    return _firebaseFirestore
        .collection('rooms')
        .doc(code)
        .snapshots()
        .map((snap) => RoomModel.fromJson(snap.data()!));
  }
}
