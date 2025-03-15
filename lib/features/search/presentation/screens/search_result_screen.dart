// features/search/presentation/screens/search_result_screen.dart
import 'package:flutter/material.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/persentaion/widget/restaurant_widgets/vertical_restaurant_card.dart';
import '../../../home/persentaion/widget/search_with_filter.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: "Search Result",
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppSearchBarWithFilter(
                controller: searchController,
                hasFilter: true,
                enableSearch: true,
                filterIconColor: AppTheme.appGrey15,
                onFilterClick: () {},
                onTextChangeListener: (p0) {
                  setState(() {});
                },
                hintTxt: "Search for restaurant, cuisines....",
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      VerticalRestaurantCard(),
                      index % 2 == 0
                          ? Container(
                              width: double.infinity,
                              height: 150,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 130,
                                    height: 150,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 7,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.appGrey8,
                                        ),
                                        color: AppTheme.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          "https://s3-alpha-sig.figma.com/img/952a/0bb4/9ae8b4e2b41dce4f68e8ec0d19430726?Expires=1742774400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oDhIFQ1GjQEhmq89TuYlRmo0SG7bSBb8P0zpvA6KpgjWhTS3W2h95JhPPsdhMPgn8ZtEStgEvbMicbOYlWOzCKKF~sYB07jbEuSgzkZRBXANZHTp571AQOJFMD0aGOlbbZTKoWKPoUXy2Lo9ZXE7h1lufVKW5J4zCICfiPOXZ6PWq06Qvxq1oS1fg8uAXpORk9T07VG0GygAKXuO49Erv89yBUr9zIKl-9V0LLJbaudWNa97RqDjjSU6VGBU6y3VON44O6omx7tKF3zsKcNtedx~z-OxFW9P8euqlSrjGP4A9xGr6gXY3WK97RQJx63gPmWyBT53Y6Skpifhm15WNg__",
                                          width: 56,
                                          height: 56,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          "Original Mushroom Burger",
                                          textAlign: TextAlign.center,
                                          style: AppTheme
                                              .fonStyle13W50022252BColor,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "45.99 ",
                                              style: AppTheme
                                                  .fontStyleW70018code008080Color,
                                            ),
                                            Text(
                                              "LE",
                                              style: AppTheme
                                                  .fontStyleW70018code008080Color
                                                  .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
