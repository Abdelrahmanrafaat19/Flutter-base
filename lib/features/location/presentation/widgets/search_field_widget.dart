import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/persentaion/widget/search_with_filter.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({super.key});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppSearchBarWithFilter(
      hasFilter: false,
      enableSearch: false,
      onFilterClick: () {},
      postIcon: IconButton(
        icon: SizedBox(
          width: 20,
          height: 20,
          child: SVGIcons.localSVG(
            "assets/images/closecircle.svg",
            color: AppTheme.appGrey7,
          ),
        ),
        onPressed: () => _searchController.clear(),
      ),
      hintTxt: "Type of food, restaurants name",
    );
  }
}



/* TextField(
      controller: _searchController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Search Location',
        prefixIcon: Container(
          padding: const EdgeInsets.all(10),
          width: 20,
          height: 20,
          child: SVGIcons.localSVG(
            "assets/images/search.svg",
          ),
        ),
        suffixIcon: IconButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: SVGIcons.localSVG(
              "assets/images/closecircle.svg",
              color: AppTheme.appGrey7,
            ),
          ),
          onPressed: () => _searchController.clear(),
        ),
        border: InputBorder.none,
      ),
    ); */