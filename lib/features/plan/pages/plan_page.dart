import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/appbar/custom_appbar.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../bloc/plan_bloc.dart';
import '../models/plan.dart';
import '../widgets/plan_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Planned trips'),
        BlocBuilder<PlanBloc, PlanState>(
          builder: (context, state) {
            if (state is PlansLoadedState) {
              return Expanded(
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SizedBox(height: 8),
                        for (Plan plan in state.plans) ...[
                          PlanCard(plan: plan),
                        ],
                        const SizedBox(height: 100),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 45,
                          left: 25,
                          right: 25,
                        ),
                        child: PrimaryButton(
                          title: '+ Add    ',
                          borderRadius: 32,
                          onPressed: () {
                            context.push('/add-name');
                            // context.read<PlanBloc>().add(
                            //       AddPlanEvent(
                            //         plan: PlanModel(
                            //           id: getCurrentTimestamp(),
                            //           name: 'Aaa',
                            //           departureTime: '12:12',
                            //           arrivalTime: '20:20',
                            //           from: 'Tashkent',
                            //           to: 'New-York',
                            //           date: '22.06.2024',
                            //           passenger: 1,
                            //           price: 1000,
                            //         ),
                            //       ),
                            //     );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
        const SizedBox(height: 65),
      ],
    );
  }
}
