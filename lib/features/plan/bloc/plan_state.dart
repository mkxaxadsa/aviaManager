part of 'plan_bloc.dart';

abstract class PlanState {}

class PlanInitial extends PlanState {}

class PlansLoadedState extends PlanState {
  final List<Plan> plans;
  PlansLoadedState({required this.plans});
}
