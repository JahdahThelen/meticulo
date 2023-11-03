import 'package:flutter/material.dart';
import 'package:meticulo/api/api_client.dart';
import 'package:meticulo/api/imdb_api_client.dart';
import 'package:meticulo/widget/search_app_bar.dart';

import '../model/result.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiClient _api = ImdbApiClient();
  List<Result> _results = [];

  Future<void> _search(String expression) async {
    var newResult = await _api.search(expression);
    setState(() {
      _results = newResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(onSearch: (expression) => _search(expression)),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(_results[index].title),
        ),
        itemCount: _results.length,
      )),
    );
  }
}
