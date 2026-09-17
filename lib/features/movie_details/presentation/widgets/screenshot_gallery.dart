import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';

class ScreenshotGallery extends StatelessWidget {
  final List<String> screenshots;

  const ScreenshotGallery({super.key, required this.screenshots});

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                screenshots[index],
                width: 170,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 170,
                  height: 110,
                  color: MColors.dgrey,
                  child: const Icon(Icons.image, color: MColors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}