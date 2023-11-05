import 'package:flutter/material.dart';
import 'package:meticulo/widget/buttons.dart';

class SearchAppBar extends StatelessWidget {
  final void Function(String)? onSearch;
  final void Function()? onFilter;

  const SearchAppBar({super.key, this.onSearch, this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    onSubmitted: onSearch,
                    leading: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.search),
                    ),
                  );
                },
                suggestionsBuilder: (_, __) => []),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomIconButton.filter(
              onPressed: onFilter,
            ),
          ),
        ],
      ),
    );
  }
}
