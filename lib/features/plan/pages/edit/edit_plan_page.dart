import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils.dart';
import '../../../../core/widgets/appbar/custom_appbar.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/picker/time_picker.dart';
import '../../bloc/plan_bloc.dart';
import '../../models/plan.dart';
import '../../models/transfer.dart';
import '../../widgets/field_card.dart';

class EditPlanPage extends StatefulWidget {
  const EditPlanPage({super.key, required this.plan});

  final Plan plan;

  @override
  State<EditPlanPage> createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();
  final controller7 = TextEditingController();

  bool active = true;
  String pickedTime = '';

  void onChanged(String text) {
    setState(() {
      if (controller1.text.isEmpty) {
        active = false;
      } else if (controller2.text.isEmpty) {
        active = false;
      } else if (controller3.text.isEmpty) {
        active = false;
      } else if (controller4.text.isEmpty) {
        active = false;
      } else if (controller6.text.isEmpty) {
        active = false;
      } else if (controller7.text.isEmpty) {
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

  void onEdit() {
    context.read<PlanBloc>().add(
          EditPlanEvent(
            plan: Plan(
              id: widget.plan.id,
              name: widget.plan.name,
              departureTime: widget.plan.departureTime,
              arrivalTime: widget.plan.arrivalTime,
              fromCountry: controller1.text,
              fromCity: controller2.text,
              toCountry: controller3.text,
              toCity: controller4.text,
              date: controller5.text,
              passenger: int.tryParse(controller6.text) ?? 1,
              price: int.tryParse(controller7.text) ?? 0,
              transfer: Transfer(
                date: widget.plan.transfer.date,
                timeFrom: widget.plan.transfer.timeFrom,
                timeTo: widget.plan.transfer.timeTo,
                passenger: widget.plan.transfer.passenger,
                price: widget.plan.transfer.price,
              ),
            ),
          ),
        );
    context.go('/home');
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.plan.fromCountry;
    controller2.text = widget.plan.fromCity;
    controller3.text = widget.plan.toCountry;
    controller4.text = widget.plan.toCity;
    controller5.text = widget.plan.date;
    controller6.text = widget.plan.passenger.toString();
    controller7.text = widget.plan.price.toString();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    controller7.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Plan',
            onPressed: () {
              context.pop();
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 24),
                FieldCard(
                  controller: controller1,
                  title: 'From (Country)',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller2,
                  title: 'From (City)',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller3,
                  title: 'To (Country)',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller4,
                  title: 'To (City)',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller5,
                  title: 'Date',
                  onChanged: onChanged,
                  onTap: () {
                    showDatePicker(controller5);
                  },
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller6,
                  title: 'Passenger',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 14),
                FieldCard(
                  controller: controller7,
                  title: 'Price/Hotel',
                  onChanged: onChanged,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      title: 'Edit',
                      width: 250,
                      active: active,
                      onPressed: onEdit,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
