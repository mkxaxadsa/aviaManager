import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/textfields/txt_field.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key, required this.plan});

  final Plan plan;

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final controller1 = TextEditingController();

  bool active = true;
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
      context.push(
        '/edit-transfer',
        extra: Plan(
          id: widget.plan.id,
          name: controller1.text,
          departureTime: widget.plan.departureTime,
          arrivalTime: widget.plan.arrivalTime,
          fromCountry: widget.plan.fromCountry,
          fromCity: widget.plan.fromCity,
          toCountry: widget.plan.toCountry,
          toCity: widget.plan.toCity,
          date: widget.plan.date,
          passenger: widget.plan.passenger,
          price: widget.plan.price,
          transfer: Transfer(
            date: widget.plan.transfer.date,
            timeFrom: widget.plan.transfer.timeFrom,
            timeTo: widget.plan.transfer.timeTo,
            passenger: widget.plan.transfer.passenger,
            price: widget.plan.transfer.price,
          ),
        ),
      );
    } else {
      context.push(
        '/edit-time',
        extra: Plan(
          id: widget.plan.id,
          name: controller1.text,
          departureTime: widget.plan.departureTime,
          arrivalTime: widget.plan.arrivalTime,
          fromCountry: widget.plan.fromCountry,
          fromCity: widget.plan.fromCity,
          toCountry: widget.plan.toCountry,
          toCity: widget.plan.toCity,
          date: widget.plan.date,
          passenger: widget.plan.passenger,
          price: widget.plan.price,
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
  void initState() {
    controller1.text = widget.plan.name;
    super.initState();
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
