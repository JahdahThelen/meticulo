import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final void Function(String)? onSearch;

  const SearchAppBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
    );
  }
}
