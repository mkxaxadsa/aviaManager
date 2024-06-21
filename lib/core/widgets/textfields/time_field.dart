import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.controller,
    this.hintText = '...',
    this.suffixText = '',
    this.onChanged,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final String suffixText;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          enabled: false,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey8,
            hintText: hintText,
            suffixText: suffixText,
            suffixStyle: TextStyle(
              color: AppColors.grey50,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: TextStyle(
              color: AppColors.grey40,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
