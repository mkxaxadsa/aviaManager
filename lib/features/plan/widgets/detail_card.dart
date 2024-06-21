import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../models/plan.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.blue50,
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
                          const Positioned(
                            bottom: -1.5,
                            child: Text(
                              '- — — — — — — -',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Color(0xffE0E0E0),
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 68,
                            child: SvgPicture.asset('assets/icons/plane.svg'),
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
                    Text(
                      '${formatDateForCard(plan.transfer.date)} | ${plan.passenger} Seat',
                      style: TextStyle(
                        color: AppColors.grey50,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: AppColors.bg,
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  color: AppColors.bg,
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
    );
  }
}
