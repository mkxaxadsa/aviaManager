import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/textfields/txt_field.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  final controller1 = TextEditingController();

  bool active = false;
  bool expanded = false;
  bool transfer = false;

  void onChanged(String text) {
    setState(() {
      if (controller1.text.isEmpty) {
        active = false;
      } else {
        active = true;
      }
    });
  }

  void onNext() {
    if (transfer) {
      context.push('/add-transfer', extra: controller1.text);
    } else {
      context.push(
        '/add-time',
        extra: Plan(
          id: getCurrentTimestamp(),
          name: controller1.text,
          departureTime: '',
          arrivalTime: '',
          fromCountry: '',
          fromCity: '',
          toCountry: '',
          toCity: '',
          date: '',
          passenger: 0,
          price: 0,
          transfer: Transfer(
            date: '',
            timeFrom: '',
            timeTo: '',
            passenger: 0,
            price: 0,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Create card',
            onPressed: () {
              context.pop();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  height: 126,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.grey8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: AppColors.grey40,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Make a name',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TxtField(
                        controller: controller1,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  height: expanded ? 180 : 126,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.grey8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer',
                        style: TextStyle(
                          color: AppColors.grey40,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Do you need a transfer?',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (expanded) ...[
                        _TransferButton(
                          title: 'Yes',
                          onPressed: () {
                            setState(() {
                              transfer = true;
                              expanded = false;
                            });
                            onChanged('');
                          },
                        ),
                        const SizedBox(height: 8),
                        _TransferButton(
                          title: 'No',
                          onPressed: () {
                            setState(() {
                              transfer = false;
                              expanded = false;
                            });
                            onChanged('');
                          },
                        ),
                      ] else
                        _TransferButton(
                          title: transfer ? 'Yes' : 'No',
                          onPressed: () {
                            setState(() {
                              expanded = true;
                              active = false;
                            });
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 38),
                PrimaryButton(
                  title: 'Next',
                  width: 250,
                  active: active,
                  onPressed: onNext,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferButton extends StatelessWidget {
  const _TransferButton({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.grey8,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
