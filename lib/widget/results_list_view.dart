import 'package:flutter/material.dart';

import '../model/result.dart';

class ResultsListView extends StatelessWidget {
  final List<Result> results;
  final void Function(Result) onSave;

  const ResultsListView(
      {super.key, required this.results, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Result result = results[index];
        return ListTile(
          title: Text(result.title),
          onTap: () => onSave(result),
        );
      },
      itemCount: results.length,
      shrinkWrap: true,
    );
  }
}
