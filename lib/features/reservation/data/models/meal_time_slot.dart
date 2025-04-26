class MealTimeSlots {
  String? reservationTime;
  bool? availability;

  MealTimeSlots({this.reservationTime, this.availability});

  MealTimeSlots.fromJson(Map<String, dynamic> json) {
    reservationTime = json['reservationTime'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservationTime'] = this.reservationTime;
    data['availability'] = this.availability;
    return data;
  }
}