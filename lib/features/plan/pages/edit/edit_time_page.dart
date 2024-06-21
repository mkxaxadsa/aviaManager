import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/picker/time_picker.dart';
import '../../../../core/widgets/textfields/time_field.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';

class EditTimePage extends StatefulWidget {
  const EditTimePage({super.key, required this.plan});

  final Plan plan;

  @override
  State<EditTimePage> createState() => _EditTimePageState();
}

class _EditTimePageState extends State<EditTimePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  String pickedTime = '';

  void showTimePicker(TextEditingController controller) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TimePicker(
          time: controller.text,
          onSave: () {
            setState(() {
              controller.text = pickedTime;
            });
            context.pop();
          },
          onDateTimeChanged: (newTime) {
            pickedTime = formatTime(newTime);
          },
        );
      },
    );
  }

  void onNext() {
    context.push(
      '/edit-plan',
      extra: Plan(
        id: widget.plan.id,
        name: widget.plan.name,
        departureTime: controller1.text,
        arrivalTime: controller2.text,
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
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.plan.departureTime;
    controller2.text = widget.plan.arrivalTime;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Time',
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
                  height: 144,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.grey8,
                  ),
                  child: Column(
                    children: [
                      TimeField(
                        controller: controller1,
                        suffixText: 'departure time',
                        onTap: () {
                          showTimePicker(controller1);
                        },
                      ),
                      const Spacer(),
                      TimeField(
                        controller: controller2,
                        suffixText: 'arrival time',
                        onTap: () {
                          showTimePicker(controller2);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 38),
                PrimaryButton(
                  title: 'Next',
                  width: 250,
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
