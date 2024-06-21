import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/textfields/date_field.dart';
import '../../../core/widgets/textfields/num_field.dart';
import '../../../core/widgets/textfields/txt_field.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({
    super.key,
    required this.controller,
    required this.title,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final String title;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.grey8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          if (title == 'Date')
            DateField(
              controller: controller,
              onTap: onTap,
              onChanged: onChanged,
            )
          else if (title == 'Passenger' ||
              title == 'Price/Hotel' ||
              title == 'Price')
            NumField(
              controller: controller,
              onChanged: onChanged,
            )
          else
            TxtField(
              controller: controller,
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}
