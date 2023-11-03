import 'package:meticulo/provider/result_provider.dart';

import '../api/api_client.dart';
import '../api/imdb_api_client.dart';
import '../model/result.dart';
import '../widget/results_list_view.dart';

class ImdbProvider extends ResultProvider {
  final ApiClient _api = ImdbApiClient();
  List<Result> _searchResults = [];
  final List<Result> _savedResults = [];

  @override
  List<ListItem> get results => _searchResults
      .map((result) =>
          ListItem(result: result, isSaved: _savedResults.contains(result)))
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
    notifyListeners();
  }
}