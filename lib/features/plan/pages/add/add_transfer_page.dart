import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_test/core/widgets/textfields/time_field.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/utils.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/picker/time_picker.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';
import '../../widgets/field_card.dart';

class AddTransferPage extends StatefulWidget {
  const AddTransferPage({super.key, required this.name});

  final String name;

  @override
  State<AddTransferPage> createState() => _AddTransferPageState();
}

class _AddTransferPageState extends State<AddTransferPage> {
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
      '/add-time',
      extra: Plan(
        id: getCurrentTimestamp(),
        name: widget.name,
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
    controller1.text = getCurrentDate();
    controller2.text = getCurrentTime();
    controller3.text = getCurrentTime();
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
