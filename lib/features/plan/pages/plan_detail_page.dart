import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/appbar/custom_appbar.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/buttons/txt_button.dart';
import '../../../core/widgets/dialogs/dialog_widget.dart';
import '../bloc/plan_bloc.dart';
import '../models/plan.dart';
import '../widgets/detail_card.dart';

class PlanDetailPage extends StatelessWidget {
  const PlanDetailPage({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: plan.name,
            onPressed: () {
              context.pop();
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                DetailCard(plan: plan),
                const SizedBox(height: 16),
                _FlightCard(plan: plan),
                const SizedBox(height: 16),
                _OtherDataCard(plan: plan),
                const SizedBox(height: 58),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plan.transfer.date.isEmpty
                          ? '#No Transfer'
                          : '#Your Transfer',
                      style: TextStyle(
                        color: AppColors.grey50,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 58),
                if (plan.transfer.date.isNotEmpty) ...[
                  _TransferDataCard(
                    title: 'Date',
                    data: plan.date,
                  ),
                  const SizedBox(height: 16),
                  _TransferDataCard(
                    title: 'Passenger',
                    data: plan.transfer.passenger.toString(),
                  ),
                  const SizedBox(height: 16),
                  _TransferTimeCard(
                    from: plan.transfer.timeFrom,
                    to: plan.transfer.timeTo,
                  ),
                  const SizedBox(height: 16),
                  _TransferDataCard(
                    title: 'Price',
                    data: '${plan.transfer.price}\$',
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      title: 'Edit',
                      width: 250,
                      onPressed: () {
                        context.push('/edit-name', extra: plan);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TxtButton(
                  title: 'Delete',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          title: 'Delete plan?',
                          onPressed: () {
                            context
                                .read<PlanBloc>()
                                .add(DeletePlanEvent(id: plan.id));
                            context.pop();
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlightCard extends StatelessWidget {
  const _FlightCard({
    required this.plan,
  });

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flight',
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${plan.fromCountry} - ${plan.toCountry}',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.grey8,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  'Total price',
                  style: TextStyle(
                    color: AppColors.grey40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '${plan.price}\$',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OtherDataCard extends StatelessWidget {
  const _OtherDataCard({required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: BoxDecoration(
        color: AppColors.grey8,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          _OtherDataChild(
            title: 'Date',
            data: plan.date,
          ),
          const SizedBox(width: 8),
          _OtherDataChild(
            title: 'Passenger',
            data: plan.passenger.toString(),
          ),
          const SizedBox(width: 8),
          _OtherDataChild(
            title: 'Time',
            data: plan.arrivalTime,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _OtherDataChild extends StatelessWidget {
  const _OtherDataChild({
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 66,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey8,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.grey40,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              data,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransferDataCard extends StatelessWidget {
  const _TransferDataCard({
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grey8,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                data,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferTimeCard extends StatelessWidget {
  const _TransferTimeCard({
    required this.from,
    required this.to,
  });

  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time',
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grey8,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                from,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset('assets/icons/arrows.svg'),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.grey8,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                to,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
