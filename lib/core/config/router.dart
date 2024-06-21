import 'package:go_router/go_router.dart';

import '../../features/home/home_page.dart';
import '../../features/information/models/news_model.dart';
import '../../features/information/pages/news_detail_page.dart';
import '../../features/plan/models/plan.dart';
import '../../features/plan/pages/add/add_name_page.dart';
import '../../features/plan/pages/add/add_plan_page.dart';
import '../../features/plan/pages/add/add_time_page.dart';
import '../../features/plan/pages/add/add_transfer_page.dart';
import '../../features/plan/pages/edit/edit_name_page.dart';
import '../../features/plan/pages/edit/edit_plan_page.dart';
import '../../features/plan/pages/edit/edit_time_page.dart';
import '../../features/plan/pages/edit/edit_transfer_page.dart';
import '../../features/plan/pages/plan_detail_page.dart';
import '../../features/splash/onboard_page.dart';
import '../../features/splash/splash_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/news',
      builder: (context, state) => NewsDetailPage(
        newsModel: state.extra as NewsModel,
      ),
    ),
    GoRoute(
      path: '/plan-detail',
      builder: (context, state) => PlanDetailPage(
        plan: state.extra as Plan,
      ),
    ),
    // add
    GoRoute(
      path: '/add-name',
      builder: (context, state) => const AddNamePage(),
    ),
    GoRoute(
      path: '/add-transfer',
      builder: (context, state) => AddTransferPage(
        name: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/add-time',
      builder: (context, state) => AddTimePage(
        plan: state.extra as Plan,
      ),
    ),
    GoRoute(
      path: '/add-plan',
      builder: (context, state) => AddPlanPage(
        plan: state.extra as Plan,
      ),
    ),
    // edit
    GoRoute(
      path: '/edit-name',
      builder: (context, state) => EditNamePage(
        plan: state.extra as Plan,
      ),
    ),
    GoRoute(
      path: '/edit-transfer',
      builder: (context, state) => EditTransferPage(
        plan: state.extra as Plan,
      ),
    ),
    GoRoute(
      path: '/edit-time',
      builder: (context, state) => EditTimePage(
        plan: state.extra as Plan,
      ),
    ),
    GoRoute(
      path: '/edit-plan',
      builder: (context, state) => EditPlanPage(
        plan: state.extra as Plan,
      ),
    ),
  ],
);
