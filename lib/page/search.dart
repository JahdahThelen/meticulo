import 'package:flutter/material.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:meticulo/widget/dialogs.dart';
import 'package:meticulo/widget/results_list_view.dart';
import 'package:meticulo/widget/search_app_bar.dart';
import 'package:provider/provider.dart';

import '../widget/no_results.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Consumer<ResultProvider>(builder: (context, provider, _) {
              if (provider.results.isEmpty) return const NoResults();
              return ResultsListView(
                  results: provider.results,
                  onSave: (item) => onSave(context, item),
                  onRate: (item) => onRate(context, item));
            }),
          ),
          SearchAppBar(
            onSearch: (expression) => onSearch(context, expression),
            //onFilter: () => onFilter(context),
          )
        ],
      ),
    );
  }

  void onSave(BuildContext context, ResultListDTO item) {
    Provider.of<ResultProvider>(context, listen: false).save(item);
  }

  void onSearch(BuildContext context, String expression) {
    Provider.of<ResultProvider>(context, listen: false).search(expression);
  }

  void onRate(BuildContext context, ResultListDTO item) {
    RatingDialog(context).showRating(
        title: item.result.title,
        rating: item.rating,
        onConfirmation: (newRating) {
          Provider.of<ResultProvider>(context, listen: false)
              .rate(item, newRating);
        });
  }
}
