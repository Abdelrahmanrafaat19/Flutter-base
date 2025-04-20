import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSliderPreview extends StatelessWidget {
  ImageSliderPreview({super.key});

  final List<String> imageUrls = [
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    // زوّد الصور حسب الحاجة
  ];

  final int maxVisibleImages = 5;

  @override
  Widget build(BuildContext context) {
    int extraCount = imageUrls.length - maxVisibleImages;
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 6;
    double totalSpacing = spacing * (maxVisibleImages - 1);
    double imageSize = (screenWidth - totalSpacing - 32) / maxVisibleImages; // 32 = 16 left + 16 right padding


    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          imageUrls.length > maxVisibleImages
              ? maxVisibleImages
              : imageUrls.length,
              (index) {
            bool isLastVisible = index == maxVisibleImages - 1 &&
                imageUrls.length > maxVisibleImages;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrls[index],
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