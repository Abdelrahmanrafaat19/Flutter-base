// features/search/presentation/widgets/intil_body_for_search_screen.dart
import 'package:flutter/material.dart';
import 'search_item_list_initil_body.dart';

// ignore: must_be_immutable
class IntilBodyForSearchScreen extends StatelessWidget {
  final List<dynamic> data;
  const IntilBodyForSearchScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return SearchItemListInitilBody(
          listLength: data.length,
          index: index,
          title: data[index]["title"],
          iconPath: data[index]["iconPath"],
          hasSubTitle: data[index]["hasSubTitle"],
          subTitle: data[index]["subTitle"],
        );
      },
    );
  }
}
