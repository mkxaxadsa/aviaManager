import 'package:flutter/cupertino.dart';

import '../../config/app_colors.dart';

class IcoButton extends StatelessWidget {
  const IcoButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 44,
        width: 44,
        child: Icon(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }
}
