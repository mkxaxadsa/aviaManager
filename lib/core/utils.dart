import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool onboarding = true;

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  onboarding = prefs.getBool('onboarding') ?? true;
  log('onboarding = $onboarding');
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

String formatCountry(String country) {
  if (country.length > 3) {
    return country.substring(0, 3).toUpperCase();
  } else {
    return country.toUpperCase();
  }
}

String getDifferenceTime(String from, String to) {
  DateFormat format = DateFormat('hh:mm a');
  Duration difference = format.parse(from).difference(format.parse(to));
  int hours = difference.inMinutes ~/ 60;
  int minutes = difference.inMinutes % 60;
  String formatted =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  List<String> parts = formatted.split(':');
  int h = int.parse(parts[0]);
  int m = int.parse(parts[1]);
  String formattedTime = '${h}h ${m}m'.replaceAll('-', '');
  return formattedTime;
}

String convertMinutesToTime(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;

  DateTime time = DateTime(0, 1, 1, hours, minutes);

  DateFormat format = DateFormat('hh:mm a');
  return format.format(time);
}

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

String getCurrentTime() {
  return DateFormat('hh:mm a').format(DateTime.now());
}

String getDifference(String time) {
  int totalMinutes = int.parse(time);
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  String formattedTime =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  return formattedTime;
}

String getCurrentDate() {
  return DateFormat('dd/MM/yyyy').format(DateTime.now());
}

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

DateTime parseTimeString(String timeString) {
  try {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    return dateTime;
  } catch (e) {
    return DateTime.now();
  }
}

String formatDateForCard(String date) {
  try {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(date);
    DateFormat outputFormat = DateFormat('EEEE, dd MMMM yyyy');
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  } catch (e) {
    return 'Saturday, 22 June 2024';
  }
}

DateTime parseDate(String date) {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime dateTime = dateFormat.parse(date);
  return dateTime;
}
