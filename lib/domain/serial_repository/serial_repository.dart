import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/serial_local_data_source/serial_local_data_source.dart';
import 'package:moviebuddy/data/serial_model/serial_model.dart';
import 'package:moviebuddy/data/serial_remote_data_source/serial_remote_data_source.dart';

abstract class SerialRepository {
  Future<List<SerialModel>> getSerials();
}

class SerialRepositoryImpl implements SerialRepository {
  final SerialLocalDataSource serialLocalDataSource;
  final SerialRemoteDataSource serialRemoteDataSource;

  SerialRepositoryImpl({
    required this.serialLocalDataSource,
    required this.serialRemoteDataSource,
  });

  @override
  Future<List<SerialModel>> getSerials() async {
    try {
      final cashedSerials = await serialLocalDataSource.getCashedSerials();
      if (cashedSerials.isNotEmpty) {
        return cashedSerials;
      } else {
        final serials = await serialRemoteDataSource.getSerials();
        await serialLocalDataSource.cashedSerials(serials);
        return serials;
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error getting cashed serials: $error, $stackTrace');
      }
      final serials = await serialRemoteDataSource.getSerials();
      await serialLocalDataSource.cashedSerials(serials);
      return serials;
    }
  }
}
