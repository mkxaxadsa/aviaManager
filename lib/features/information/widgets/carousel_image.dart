import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/app_colors.dart';
import '../models/different.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({
    super.key,
    required this.different,
    required this.index,
  });

  final Different different;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 200,
            width:
                MediaQuery.of(context).size.width > 400 ? 400 : double.infinity,
            child: CachedNetworkImage(
              imageUrl: different.url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 4,
          bottom: 4,
          child: SizedBox(
            width: 150,
            child: Text(
              different.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
