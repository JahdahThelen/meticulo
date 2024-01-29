import 'package:meticulo/model/rated_results.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:meticulo/storage/abstract_storage.dart';

import '../api/api_client.dart';
import '../model/result.dart';
import '../widget/results_list_view.dart';

enum ResultsType { searched, saved, rated }

class ImdbProvider extends ResultProvider {
  ResultsType _resultsType = ResultsType.saved;
  final AbstractStorage? _storage;
  final ApiClient _api;
  List<Result> _searchResults = [];
  List<Result> _savedResults = [];
  RatedResults _ratedResults = RatedResults.empty();

  ImdbProvider(this._storage, this._api) {
    loadData();
  }

  Future<void> loadData() async {
    if (_storage == null) return;
    _savedResults = await _storage!.readSavedResults();
    _ratedResults = await _storage!.readRatedResults();
    notifyListeners();
  }

  @override
  List<ResultListDTO> get results {
    switch (_resultsType) {
      case ResultsType.searched:
        return searchResults;
      case ResultsType.saved:
        return savedResults;
      case ResultsType.rated:
        return ratedResults;
    }
  }

  List<ResultListDTO> get searchResults => _searchResults
      .map((result) => ResultListDTO(
          result: result,
          isSaved: _savedResults.contains(result),
          rating: _ratedResults[result] ?? 0))
      .toList(growable: false);

  List<ResultListDTO> get savedResults => _savedResults
      .map((result) => ResultListDTO(
          result: result, isSaved: true, rating: _ratedResults[result] ?? 0))
      .toList(growable: false);

  List<ResultListDTO> get ratedResults => _ratedResults.entries
      .map((entry) => ResultListDTO(
          result: entry.key,
          isSaved: _savedResults.contains(entry.key),
          rating: entry.value))
      .toList(growable: false);

  @override
  Future<void> search(String expression) async {
    if (expression.isEmpty) {
      _resultsType = ResultsType.saved;
      notifyListeners();
      return;
    }
    _resultsType = ResultsType.searched;
    List<Result> newResult = await _api.search(expression);
    _searchResults = newResult;
    notifyListeners();
  }

  @override
  void save(ResultListDTO item) {
    Result result = item.result;
    if (_savedResults.contains(result)) {
      _savedResults.remove(result);
    } else {
      _savedResults.add(result);
    }
    _saveSavedToStorage();
    notifyListeners();
  }

  void _saveSavedToStorage() {
    if (_storage == null) return;
    _storage!.updateSavedResults(_savedResults);
  }

  @override
  void rate(ResultListDTO item, int newRating) {
    _ratedResults.update(
      item.result,
      (rating) => rating = newRating,
      ifAbsent: () => newRating,
    );
    _saveRatedToStorage();
    notifyListeners();
  }

  void _saveRatedToStorage() {
    if (_storage == null) return;
    _storage!.updateRatedResults(_ratedResults);
  }
}
