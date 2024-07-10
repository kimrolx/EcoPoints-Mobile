import 'package:flutter/cupertino.dart';

import '../../../../components/fields/search-bar-field/custom_search_bar_field.dart';

class SearchBarRewardsScreen extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFn;
  const SearchBarRewardsScreen(
      {super.key, required this.searchController, required this.searchFn});

  @override
  Widget build(BuildContext context) {
    return CustomSearchBarField(
      controller: searchController,
      hintText: "Search reward",
      onEditingComplete: () {
        searchFn.unfocus();
        //TODO: add search handler here
      },
      prefixIcon: const Icon(
        CupertinoIcons.search,
        size: 25,
      ),
    );
  }
}
