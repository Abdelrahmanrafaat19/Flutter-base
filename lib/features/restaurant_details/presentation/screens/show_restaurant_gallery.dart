import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/banner_card_items.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/svg_icons.dart';

class ShowRestaurantGallery extends StatelessWidget {
  final List<String> imagesList;
  const ShowRestaurantGallery({super.key, required this.imagesList});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BannerCardItems(
          list: imagesList,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          showLoading: false,
          showIndicator: imagesList.isNotEmpty,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16,vertical: 40),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  context.pop();
                },
                child: SVGIcons.localSVG(backWithGrayBackgroundIcon,
                    width: 32, height: 32),
              ),
              Spacer()
            ],
          ),
        ),
      ],
    );
  }
}
