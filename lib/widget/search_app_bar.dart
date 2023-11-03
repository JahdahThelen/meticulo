import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onSearch;

  const SearchAppBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onSubmitted: onSearch,
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (_, __) => []),
        elevation: 5,
        clipBehavior: Clip.none);
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
