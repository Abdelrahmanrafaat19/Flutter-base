import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/persentaion/widget/category_widgets/restaurant_category.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../title_with_see_all.dart';

class HorizontalCuisinesListWithTitle extends StatefulWidget {
  final List<Cuisine> list;
  final bool showLoading;
  final VoidCallback itemClick;
  final VoidCallback onSeeAllClickListener;
  const HorizontalCuisinesListWithTitle(
      {super.key,
        required this.list,
        required this.showLoading,
        required this.itemClick, required this.onSeeAllClickListener});

  @override
  State<HorizontalCuisinesListWithTitle> createState() => _HorizontalCuisinesListWithTitleState();
}

class _HorizontalCuisinesListWithTitleState extends State<HorizontalCuisinesListWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Skeletonizer(
            enabled: widget.showLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
              child: TitleWithSeeAll(
                title: "Cuisines",
                onClickOnSeeAll: () {
                  widget.onSeeAllClickListener.call();
                },
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Skeletonizer(
                    enabled: widget.showLoading ,
                    child: InkWell(
                      onTap: (){
                        widget.itemClick.call();
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: defaultPaddingHorizontal),
                        child: CuisineCard(
                          width: 110,
                          height: 80,
                          categoryImg: "https://t3.ftcdn.net/jpg/02/52/38/80/360_F_252388016_KjPnB9vglSCuUJAumCDNbmMzGdzPAucK.jpg",
                          categoryName: widget.list[index].name,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context , index) => const SizedBox(
                  width: 0,
                ),
                itemCount: widget.showLoading ? 5 : widget.list.length),
          ),
        ]
    );
  }
}
