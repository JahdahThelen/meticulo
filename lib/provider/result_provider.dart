import 'package:flutter/material.dart';

import '../widget/results_list_view.dart';

abstract class ResultProvider extends ChangeNotifier {
  List<ListItem> get results;

  Future<void> search(String expression);

  void save(ListItem item);

  void rate(ListItem item, int newRating);
}
