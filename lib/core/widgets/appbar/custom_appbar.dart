import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onPressed != null) ...[
              CupertinoButton(
                onPressed: onPressed,
                padding: EdgeInsets.zero,
                child: const SizedBox(
                  width: 42,
                  height: 42,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.purple,
                  ),
                ),
              ),
            ],
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (onPressed != null) const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}
