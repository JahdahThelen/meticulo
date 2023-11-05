import 'package:meticulo/model/rated_results.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:meticulo/storage/abstract_storage.dart';

import '../api/api_client.dart';
import '../api/imdb_api_client.dart';
import '../model/result.dart';
import '../widget/results_list_view.dart';

class ImdbProvider extends ResultProvider {
  final AbstractStorage? _storage;
  final ApiClient _api = ImdbApiClient();
  List<Result> _searchResults = [];
  List<Result> _savedResults = [];
  RatedResults _ratedResults = RatedResults.empty();

  ImdbProvider(this._storage) {
    loadData();
  }

  Future<void> loadData() async {
    if (_storage == null) return;
    _savedResults = await _storage!.readSavedResults();
    _ratedResults = await _storage!.readRatedResults();
  }

  @override
  List<ListItem> get results => _searchResults
      .map((result) => ListItem(
          result: result,
          isSaved: _savedResults.contains(result),
          rating: _ratedResults[result] ?? 0))
      .toList(growable: false);

  @override
  Future<void> search(String expression) async {
    List<Result> newResult = await _api.search(expression);
    _searchResults = newResult;
    notifyListeners();
  }

  @override
  void save(ListItem item) {
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
  void rate(ListItem item, int newRating) {
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
