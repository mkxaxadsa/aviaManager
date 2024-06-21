import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_colors.dart';
import '../../utils.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    required this.time,
    this.date = false,
    required this.onSave,
    required this.onDateTimeChanged,
  });

  final String time;
  final bool date;
  final void Function() onSave;
  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      decoration: const BoxDecoration(
        color: Color(0xff131313),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            height: 5,
            width: 36,
            decoration: BoxDecoration(
              color: AppColors.grey30,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 6),
          Material(
            color: Colors.transparent,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  date ? 'Date' : 'Time',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: onSave,
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CupertinoButton(
                  onPressed: () {
                    context.pop();
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.close_sharp,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            color: AppColors.grey8,
          ),
          const Spacer(),
          SizedBox(
            height: 214,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  pickerTextStyle: TextStyle(
                    color: AppColors.white,
                  ),
                  dateTimePickerTextStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              child: date
                  ? CupertinoDatePicker(
                      initialDateTime: parseDate(time),
                      mode: CupertinoDatePickerMode.date,
                      minimumYear: DateTime.now().year,
                      maximumYear: 2100,
                      onDateTimeChanged: onDateTimeChanged,
                    )
                  : CupertinoDatePicker(
                      initialDateTime: parseTimeString(time),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: false,
                      onDateTimeChanged: onDateTimeChanged,
                    ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
