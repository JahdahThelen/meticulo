import 'package:meticulo/model/rated_results.dart';

import '../model/result.dart';

abstract class AbstractStorage {
  Future<void> updateSavedResults(List<Result> results);

  Future<void> updateRatedResults(RatedResults results);

  Future<List<Result>> readSavedResults();

  Future<RatedResults> readRatedResults();
}
