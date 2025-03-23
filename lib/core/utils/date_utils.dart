import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Theme/app_theme.dart';

typedef OnDateValue = Function(DateTime?);

Future<DateTime> selectDate(BuildContext context,
    {DateTime? withInitialDate}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: withInitialDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != DateTime.now()) return picked;
  return DateTime.now();
}


DateTime _setCurrentDate(int? interval,DateTime? maxDate){
  if(interval != null){
    return (maxDate??DateTime.now()).add(Duration(minutes: interval - DateTime.now().minute % 30));
    }
  return maxDate??DateTime.now();
}

void showModalDatePicker(BuildContext context, CupertinoDatePickerMode mode, double height, {required OnDateValue? onDateValue, String? header,int? interval,DateTime? initialTime,DateTime? minDate,DateTime? maxDate,bool? onlyFuture}) {
  DateTime dateTime = initialTime??_setCurrentDate(interval,maxDate);
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                        brightness: Theme.of(context).brightness),
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: mode,
                      onDateTimeChanged: (value) {
                        dateTime = value;
                      },
                      maximumDate: maxDate,
                      minuteInterval: interval??1,
                      minimumDate: onlyFuture == true ? DateTime.now() : ( minDate),
                      initialDateTime: initialTime??(interval != null ? maxDate?.add(
                        Duration(minutes: interval - DateTime.now().minute % 30),
                      ) : maxDate)??(interval != null ?  DateTime.now().add(
                        Duration(minutes: interval - DateTime.now().minute % 30),
                      ) : DateTime.now()),
                      minimumYear: 1930,
                      maximumYear: 2050,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDateValue!(dateTime);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: AppTheme.appSwatch),
                      )),
                )
              ],
            ),
          ),
        );
      });
}

extension FormattedDate on String {
  String ddMmYyyy() {
    // Parse the input date string into a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Define the desired date format
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    // Format the DateTime object into the desired format
    return dateFormat.format(dateTime);
  }
  String hhMm(){
    DateTime dateTime = DateTime.parse(this);

    DateFormat dateFormat = DateFormat("hh:mm a");

    return dateFormat.format(dateTime);
  }
}

class DateUtilsClass {
  static String convertTimeStringToDayTime(String time) {
    return DateFormat('hh a').format(DateFormat("hh:mm:ss").parse(time));
  }

  static String convertFormatFromTo(String from, String to, String dateTime) {
    return DateFormat(to).format(DateFormat(from).parse(dateTime));
  }

  static List<DateTime> generateDateList(DateTime? startDate, DateTime? endDate) {

    List<DateTime> dateList = [];
    if(startDate == null) return [];
    if(endDate == null) return [startDate];

    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      dateList.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dateList;
  }
}
