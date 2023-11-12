import 'package:flutter/material.dart';

import '../model/result.dart';

class ResultsListView extends StatelessWidget {
  final List<ListItem> results;
  final void Function(ListItem) onSave;
  final void Function(ListItem) onRate;

  const ResultsListView(
      {super.key,
      required this.results,
      required this.onSave,
      required this.onRate});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(
          child: Text("Nothing to show.", style: TextStyle(fontSize: 20)));
    }

    return ListView.separated(
      reverse: true,
      itemBuilder: (context, index) {
        ListItem item = results[index];
        return ListTile(
          title: Text(item.result.title),
          onTap: () => onSave(item),
          onLongPress: () => onRate(item),
          leading: Icon(
            Icons.bookmark,
            color: item.isSaved ? Colors.black54 : Colors.transparent,
          ),
          subtitle: item.rating == 0
              ? null
              : Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      Icon(i < item.rating ? Icons.star : Icons.star_border,
                          color: Colors.black45)
                  ],
                ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: results.length,
      shrinkWrap: true,
    );
  }
}

class ListItem {
  final Result result;
  final bool isSaved;
  final int rating;

  ListItem({required this.result, required this.isSaved, required this.rating});
}
