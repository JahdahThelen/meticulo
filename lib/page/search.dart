import 'package:flutter/material.dart';
import 'package:meticulo/api/api_client.dart';
import 'package:meticulo/api/imdb_api_client.dart';
import 'package:meticulo/widget/results_list_view.dart';
import 'package:meticulo/widget/search_app_bar.dart';

import '../model/result.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiClient _api = ImdbApiClient();
  List<Result> _searchResults = [];
  List<Result> _savedResults = [];

  Future<void> _search(String expression) async {
    List<Result> newResult = await _api.search(expression);
    setState(() {
      _searchResults = newResult;
    });
  }

  void _save(Result result) {
    setState(() {
      _savedResults.add(result);
    });
    print(_savedResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: ResultsListView(
                results: _searchResults, onSave: (result) => _save(result)),
          ),
          SearchAppBar(onSearch: (expression) => _search(expression))
        ],
      ),
    );
  }
}
