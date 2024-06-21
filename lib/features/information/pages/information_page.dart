import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/appbar/custom_appbar.dart';
import '../models/different.dart';
import '../models/news_model.dart';
import '../widgets/carousel_image.dart';
import '../widgets/dash_plane.dart';
import '../widgets/news_card.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'News'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            children: [
              Container(
                height: 30,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Different places',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    DashPlane(dash: '- — — — — — — — — -', right: 80),
                  ],
                ),
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 200,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
                itemCount: differentImages.length,
                itemBuilder: (context, index, realIndex) {
                  return CarouselImage(
                    different: differentImages[index],
                    index: index,
                  );
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PageIndicator(active: _index == 0),
                  _PageIndicator(active: _index == 1),
                  _PageIndicator(active: _index == 2),
                  _PageIndicator(active: _index == 3),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Good place',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              ...List<Widget>.generate(
                getAllNews().length,
                (index) {
                  return NewsCard(
                    newsModel: getAllNews()[index],
                    ago: index,
                    onPressed: () {
                      context.push('/news', extra: getAllNews()[index]);
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        const SizedBox(height: 65),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: active ? AppColors.purple : AppColors.grey50,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
