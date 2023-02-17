class ExpenseDataModel {

  String? title;
  double? Amount;
  int? type;
  String? date;

  // be model

  ExpenseDataModel({this.title, this.Amount, this.type, this.date});

  ExpenseDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    Amount = json['Amount'];
    type = json['type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['Amount'] = Amount;
    data['type'] = type;
    data['date'] = date;
    return data;
  }
}
