import 'meal_time_slot.dart';

class AvaliableTimeModel {
  List<MealTimeSlots>? breakfastTimeSlots;
  List<MealTimeSlots>? lunchTimeslots;
  List<MealTimeSlots>? dinnerTimeslots;
  int? maxReservationCapacity;

  AvaliableTimeModel(
      {this.breakfastTimeSlots,
      this.lunchTimeslots,
      this.maxReservationCapacity});

  AvaliableTimeModel.fromJson(Map<String, dynamic> json) {
    if (json['breakfastTimeSlots'] != null) {
      breakfastTimeSlots = <MealTimeSlots>[];
      json['breakfastTimeSlots'].forEach((v) {
        breakfastTimeSlots!.add(new MealTimeSlots.fromJson(v));
      });
    }
    if (json['lunchTimeslots'] != null) {
      lunchTimeslots = <MealTimeSlots>[];
      json['lunchTimeslots'].forEach((v) {
        lunchTimeslots!.add(new MealTimeSlots.fromJson(v));
      });
    }
    if (json['dinnerTimeslots'] != null) {
      dinnerTimeslots = <MealTimeSlots>[];
      json['dinnerTimeslots'].forEach((v) {
        dinnerTimeslots!.add(new MealTimeSlots.fromJson(v));
      });
    }
    maxReservationCapacity = json['maxReservationCapacity'];
  }
}
