class ReversationDataModel {
  String? reservationDate;
  int? guestCount;
  String? occasion;
  String? guestName;
  String? guestPhone;

  ReversationDataModel(
      {this.reservationDate,
        this.guestCount,
        this.occasion,
        this.guestName,
        this.guestPhone});

  ReversationDataModel.fromJson(Map<String, dynamic> json) {
    reservationDate = json['reservationDate'];
    guestCount = json['guestCount'];
    occasion = json['occasion'];
    guestName = json['guestName'];
    guestPhone = json['guestPhone'];
  }


}