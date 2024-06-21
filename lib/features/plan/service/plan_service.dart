import 'package:hive_flutter/hive_flutter.dart';

import '../models/plan.dart';

class PlanService {
  // PlanService() {
  //   Hive.registerAdapter(PlanAdapter());
  //   Hive.registerAdapter(TransferAdapter());
  // }

  List<Plan> plans = [];

  Future<List<Plan>> getPlans() async {
    final box = await Hive.openBox('travelbox');
    List plans2 = box.get('plans') ?? [];
    plans = plans2.cast<Plan>();
    return plans;
  }

  Future<List<Plan>> updatePlans() async {
    final box = await Hive.openBox('travelbox');
    box.put('plans', plans);
    plans = await box.get('plans');
    return plans;
  }
}
