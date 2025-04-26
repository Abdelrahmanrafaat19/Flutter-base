import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/restaurant_details/presentation/screens/restaurant_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/circle_image.dart';
import 'Image_slider_preview.dart';

class BannerCardItems extends StatefulWidget {
  final List<String> list;
  final String? mainImage;
  final bool showIndicator;
  final double height;
  final double width;
  final BorderRadiusDirectional? radius;
  final bool showLoading;
  final bool? showShadow;
  const BannerCardItems({
    super.key,
    required this.list,
    this.showIndicator = true,
    required this.height,
    required this.width,
    required this.showLoading,
    this.radius,
    this.mainImage, this.showShadow,
  });

  @override
  State<BannerCardItems> createState() => _BannerCardItemsState();
}

class _BannerCardItemsState extends State<BannerCardItems> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            children:
                (widget.mainImage != null ? [widget.mainImage] : widget.list)
                    .map((imagePath) {
              return Skeletonizer(
                enabled: widget.showLoading,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.radius,
                  ),
                  height: widget.height,
                  width: widget.width,
                  clipBehavior: Clip.antiAlias,
                  child: Skeleton.replace(
                    replacement: Container(
                      width: widget.width, // Adjust dimensions as needed
                      height: widget.height,
                      color: Colors.white,
                    ),
                    child: ImageView(
                      initialImg: imagePath,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          widget.showShadow == true ? Container(
            width: double.infinity,
            height: widget.height,
            color: Colors.black.withOpacity(.5),
          ) : const SizedBox(),
          widget.showIndicator
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ImageSliderPreview(
                      imageUrls: widget.list,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
