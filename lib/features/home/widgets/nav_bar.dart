import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 65,
          color: Colors.black,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  _NavBarButton(
                    title: 'Information',
                    active: state is HomeInitial,
                    onPressed: () {
                      context.read<HomeBloc>().add(ChangePageEvent(index: 0));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _NavBarButton(
                    title: 'Plan',
                    active: state is HomePlan,
                    onPressed: () {
                      context.read<HomeBloc>().add(ChangePageEvent(index: 1));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _NavBarButton(
                    title: 'Settings',
                    active: state is HomeSettings,
                    onPressed: () {
                      context.read<HomeBloc>().add(ChangePageEvent(index: 2));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 100,
        // color: AppColors.grey60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            active
                ? SvgPicture.asset(
                    'assets/icons/${title.toLowerCase()}.svg',
                    color: Color.fromARGB(255, 255, 0, 0),
                  )
                : SvgPicture.asset(
                    'assets/icons/${title.toLowerCase()}.svg',
                  ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 155, 153, 153),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}

class ScreenWatching extends StatelessWidget {
  final String data;

  const ScreenWatching({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(data)),
      ),
    );
  }
}
