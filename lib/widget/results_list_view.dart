import 'package:flutter/material.dart';

import '../model/result.dart';

class ResultsListView extends StatelessWidget {
  final List<ListItem> results;
  final void Function(ListItem) onSave;

  const ResultsListView(
      {super.key, required this.results, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ListItem item = results[index];
        return ListTile(
          title: Text(item.result.title),
          onTap: () => onSave(item),
          leading: Icon(
            Icons.bookmark,
            color: item.isSaved ? Colors.black45 : Colors.transparent,
          ),
        );
      },
      itemCount: results.length,
      shrinkWrap: true,
    );
  }
}

class ListItem {
  final Result result;
  final bool isSaved;

  ListItem({required this.result, required this.isSaved});
}
