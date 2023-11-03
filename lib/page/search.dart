import 'package:flutter/material.dart';
import 'package:meticulo/provider/result_provider.dart';
import 'package:meticulo/widget/results_list_view.dart';
import 'package:meticulo/widget/search_app_bar.dart';
import 'package:provider/provider.dart';

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
              return ResultsListView(
                  results: provider.results,
                  onSave: (item) => onSave(context, item));
            }),
          ),
          SearchAppBar(onSearch: (expression) => onSearch(context, expression))
        ],
      ),
    );
  }

  void onSave(BuildContext context, ListItem item) {
    Provider.of<ResultProvider>(context, listen: false).save(item);
  }

  void onSearch(BuildContext context, String expression) {
    Provider.of<ResultProvider>(context, listen: false).search(expression);
  }
}
