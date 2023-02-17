import 'package:flutter/material.dart';

class ExpenseDataCalculationProvider extends ChangeNotifier {

  double total = 0;
  double income=0;
  double expense=0;

  void setTotalValue(dynamic total){
    this.total=total;
    notifyListeners();
  }

  void setIncomeValue(dynamic income){
    this.income=income;
    notifyListeners();
  }

  void setExpenseValue(dynamic expense){
    this.expense=expense;
    notifyListeners();
  }

}