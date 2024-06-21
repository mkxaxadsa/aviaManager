import 'package:flutter/cupertino.dart';

import '../../config/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.borderRadius = 16,
    this.width,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final double borderRadius;
  final double? width;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: active ? AppColors.blue : AppColors.grey8,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: active ? onPressed : null,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: active ? AppColors.white : AppColors.grey30,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
