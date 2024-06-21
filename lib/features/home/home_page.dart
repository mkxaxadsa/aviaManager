import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../information/pages/information_page.dart';
import '../plan/bloc/plan_bloc.dart';
import '../plan/pages/plan_page.dart';
import '../settings/settings_page.dart';
import 'bloc/home_bloc.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(GetPlansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeSettings) {
                  return const SettingsPage();
                }

                if (state is HomePlan) {
                  return const PlanPage();
                }

                return const InformationPage();
              },
            ),
            const NavBar(),
          ],
        ),
      ),
    );
  }
}
