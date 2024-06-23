import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flighter_manager/core/widgets/textfields/time_field.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/picker/time_picker.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';
import '../../widgets/field_card.dart';

class EditTransferPage extends StatefulWidget {
  const EditTransferPage({super.key, required this.plan});

  final Plan plan;

  @override
  State<EditTransferPage> createState() => _EditTransferPageState();
}

class _EditTransferPageState extends State<EditTransferPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();

  bool active = false;
  String pickedTime = '';

  void onChanged(String text) {
    setState(() {
      if (controller4.text.isEmpty) {
        active = false;
      } else if (controller5.text.isEmpty) {
        active = false;
      } else {
        active = true;
      }
    });
  }

  void showDatePicker(TextEditingController controller) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TimePicker(
          time: controller.text,
          date: true,
          onSave: () {
            setState(() {
              controller.text = pickedTime;
            });
            context.pop();
          },
          onDateTimeChanged: (newTime) {
            pickedTime = formatDate(newTime);
          },
        );
      },
    );
  }

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

  void onArrows() {
    String from = controller2.text;
    String to = controller3.text;
    setState(() {
      controller2.text = to;
      controller3.text = from;
    });
  }

  void onNext() {
    context.push(
      '/edit-time',
      extra: Plan(
        id: widget.plan.id,
        name: widget.plan.name,
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
          date: controller1.text,
          timeFrom: controller2.text,
          timeTo: controller3.text,
          passenger: int.parse(controller4.text),
          price: int.parse(controller5.text),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.plan.transfer.date.isEmpty) {
      controller1.text = getCurrentDate();
      controller2.text = getCurrentTime();
      controller3.text = getCurrentTime();
    } else {
      controller1.text = widget.plan.transfer.date;
      controller2.text = widget.plan.transfer.timeFrom;
      controller3.text = widget.plan.transfer.timeTo;
      controller4.text = widget.plan.transfer.passenger.toString();
      controller5.text = widget.plan.transfer.price.toString();
      active = true;
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Transfer',
            onPressed: () {
              context.pop();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                FieldCard(
                  controller: controller1,
                  title: 'Date',
                  onTap: () {
                    showDatePicker(controller1);
                  },
                ),
                const SizedBox(height: 19),
                FieldCard(
                  controller: controller4,
                  title: 'Passenger',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 19),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.grey8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                          color: AppColors.grey40,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7),
                      TimeField(
                        controller: controller2,
                        onTap: () {
                          showTimePicker(controller2);
                        },
                      ),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: onArrows,
                        padding: EdgeInsets.zero,
                        child: Container(
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
                      ),
                      const SizedBox(height: 8),
                      TimeField(
                        controller: controller3,
                        onTap: () {
                          showTimePicker(controller3);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 19),
                FieldCard(
                  controller: controller5,
                  title: 'Price',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 19),
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
