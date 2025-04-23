String getOpenStatus(String? openTime, String? closeTime) {
  if(openTime?.isEmpty == true || closeTime?.isEmpty == true) return "";
  final now = DateTime.now();

  final open = DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(openTime!.split(':')[0]),
    int.parse(openTime.split(':')[1]),
  );

  int closeHour = int.parse(closeTime!.split(':')[0]);
  int closeMinute = int.parse(closeTime.split(':')[1]);
  var close = DateTime(now.year, now.month, now.day, closeHour, closeMinute);

  if (close.isBefore(open)) {
    close = close.add(Duration(days: 1));
  }

  bool isOpenNow = now.isAfter(open) && now.isBefore(close);

  String formattedCloseTime = formatTime(close);

  return isOpenNow ? 'Open Now, Closes at $formattedCloseTime' : 'Closed';
}

String formatTime(DateTime time) {
  int hour = time.hour;
  int minute = time.minute;
  String period = hour >= 12 ? "PM" : "AM";

  int hour12 = hour % 12;
  if (hour12 == 0) hour12 = 12;

  String minuteStr = minute < 10 ? '0$minute' : '$minute';

  return "$hour12:$minuteStr $period";
}

String formatTo12Hour(String rawTime) {
  if(rawTime.isEmpty) return "";
  List<String> timeParts = rawTime.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  String period = hour >= 12 ? "PM" : "AM";

  int hour12 = hour % 12;
  if (hour12 == 0) hour12 = 12; // Convert 0 to 12 in 12-hour format

  String minuteStr = minute < 10 ? '0$minute' : '$minute';

  return "$hour12:$minuteStr $period";
}