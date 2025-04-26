class CostModel {
  double? subTotal;
  double? tax;
  double? grandTotal;

  CostModel({this.subTotal, this.tax, this.grandTotal});

  CostModel.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    tax = json['tax'];
    grandTotal = json['grandTotal'];
  }

}