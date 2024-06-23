import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flighter_manager/core/utils.dart';

import '../../core/config/app_colors.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/buttons/txt_button.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              // physics: const NeverScrollableScrollPhysics(),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                _PageContent(
                  'Simplify your travel\nto anywhere in the\nworld',
                  image: '1.png',
                  onPressed: () {
                    controller.animateToPage(
                      controller.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                _PageContent(
                  'Record your transfer',
                  image: '2.png',
                  onPressed: () {
                    controller.animateToPage(
                      controller.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                _PageContent(
                  'See and read different\ninformation about\ninteresting places.',
                  image: '3.png',
                  last: true,
                  onPressed: () async {
                    await saveBool('onboarding', false).then((_) {
                      context.go('/home');
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent(
    this.title, {
    required this.image,
    this.last = false,
    required this.onPressed,
  });

  final String title;
  final String image;
  final bool last;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          'assets/icons/$image',
          width: 424,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PrimaryButton(
            title: last ? 'Go Travel' : 'Next',
            borderRadius: 12,
            onPressed: onPressed,
          ),
        ),
        TxtButton(
          title: 'Terms of Use / Privacy Policy',
          onPressed: () {},
        ),
      ],
    );
  }
}
