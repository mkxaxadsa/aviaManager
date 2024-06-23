import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flighter_manager/features/home/widgets/nav_bar.dart';

import '../../core/config/app_colors.dart';
import '../../core/widgets/appbar/custom_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Settings'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _SettingsTile(
                title: 'Terms of use',
                icon: 'terms',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenWatching(
                          data:
                              'https://docs.google.com/document/d/1760Bvx-q50QT11ruArWE0EKTmWLXid9tN0p1zNmxN6g/edit?usp=sharing'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                title: 'Privacy Policy',
                icon: 'privacy',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenWatching(
                          data:
                              'https://docs.google.com/document/d/1ch4jfptp6eaX-BU5P8F-OAdM9PyZzg7LBj7hU3Hac1g/edit?usp=sharing'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _SettingsTile(
                title: 'Contact Support',
                icon: 'terms',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenWatching(
                          data: 'https://forms.gle/PVxj9hjo7fwMAb2v7'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.grey30,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/$icon.svg'),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Color(0xff5A5D86),
            ),
          ],
        ),
      ),
    );
  }
}
