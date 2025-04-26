import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSliderPreview extends StatelessWidget {
  List<String>? imageUrls;
  ImageSliderPreview({super.key,this.imageUrls});
  final int maxVisibleImages = 5;
  @override
  Widget build(BuildContext context) {
    int extraCount = (imageUrls?.length??0) - maxVisibleImages;
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 6;
    double totalSpacing = spacing * (maxVisibleImages - 1);
    double imageSize = (screenWidth - totalSpacing - 32) / maxVisibleImages;


    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          (imageUrls?.length??0) > maxVisibleImages
              ? maxVisibleImages
              : (imageUrls?.length??0),
              (index) {
            bool isLastVisible = index == maxVisibleImages - 1 &&
                (imageUrls?.length??0) > maxVisibleImages;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrls?[index]??"",
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isLastVisible)
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '+$extraCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}