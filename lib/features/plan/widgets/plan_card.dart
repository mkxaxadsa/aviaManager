import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../information/widgets/dash_plane.dart';
import '../models/plan.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.blue50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        Text(
                          formatCountry(plan.fromCountry),
                          style: TextStyle(
                            color: AppColors.grey60,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          plan.fromCity,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const DashPlane(width: 150, right: 66),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        Text(
                          formatCountry(plan.toCountry),
                          style: TextStyle(
                            color: AppColors.grey60,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          plan.toCity,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                '${formatDateForCard(plan.date)} | ${plan.passenger} Seat',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              _BlackCard(plan: plan),
              const SizedBox(height: 30),
            ],
          ),
        ),
        if (plan.transfer.date.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Transfer',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 124,
            decoration: BoxDecoration(
              color: AppColors.blue50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  '${formatDateForCard(plan.transfer.date)} | ${plan.transfer.passenger} Seat',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 82,
                  margin: const EdgeInsets.symmetric(horizontal: 64),
                  decoration: BoxDecoration(
                    color: AppColors.bg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Text(
                        '${plan.transfer.timeFrom} - ${plan.transfer.timeTo}',
                        style: TextStyle(
                          color: AppColors.grey50,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 14,
                            width: 11,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              color: AppColors.blue50,
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                '- — — — — — — — -',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 14,
                            width: 11,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: AppColors.blue50,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 25,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            const Text(
                              'Price',
                              style: TextStyle(
                                color: Color(0xff1F1449),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${plan.transfer.price}\$',
                              style: const TextStyle(
                                color: Color(0xff5C40CC),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}

class _BlackCard extends StatelessWidget {
  const _BlackCard({required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.push('/plan-detail', extra: plan);
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/pin.svg'),
                      const SizedBox(height: 4),
                      Text(
                        formatCountry(plan.fromCountry),
                        style: const TextStyle(
                          color: AppColors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.fromCity,
                        style: const TextStyle(
                          color: Color(0xff9698A9),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.departureTime,
                        style: const TextStyle(
                          color: Color(0xff9698A9),
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 16.5,
                        width: 155,
                        child: Stack(
                          children: [
                            Text(
                              MediaQuery.of(context).size.width > 420
                                  ? '- — — — — — — — -'
                                  : '- — — — — — — — — — -',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: AppColors.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Positioned(
                              right: 72,
                              bottom: 0,
                              child: SvgPicture.asset(
                                'assets/icons/plane.svg',
                                height: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Flight Duration',
                        style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        getDifferenceTime(
                          plan.departureTime,
                          plan.arrivalTime,
                        ),
                        style: const TextStyle(
                          color: Color(0xff9698A9),
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pin.svg',
                        color: const Color(0xff0EC3AE),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatCountry(plan.toCountry),
                        style: const TextStyle(
                          color: AppColors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.toCity,
                        style: const TextStyle(
                          color: Color(0xff9698A9),
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan.arrivalTime,
                        style: const TextStyle(
                          color: Color(0xff9698A9),
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 32,
                  width: 16,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: AppColors.blue50,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      '- — — — — — — — — — — — — -',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                  width: 16,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: AppColors.blue50,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 25,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Text(
                    'Price',
                    style: TextStyle(
                      color: Color(0xff1F1449),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${plan.price}\$',
                    style: const TextStyle(
                      color: Color(0xff5C40CC),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
