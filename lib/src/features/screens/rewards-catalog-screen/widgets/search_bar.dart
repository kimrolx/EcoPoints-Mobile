import 'package:flutter/cupertino.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/fields/search-bar-field/custom_search_bar_field.dart';

class SearchBarRewardsScreen extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFn;
  const SearchBarRewardsScreen(
      {super.key, required this.searchController, required this.searchFn});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: EcoPointsColors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: CustomSearchBarField(
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
      ),
    );
  }
}
