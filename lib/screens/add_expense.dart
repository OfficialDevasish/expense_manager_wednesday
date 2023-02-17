
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../common/global.dart';

// EventBus eventBus = EventBus();


class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  final _tag = "Add Expenses";

  final _keyForm = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  bool isNameError = false;
  bool isExpenseError = false;

  String _nameData = "";
  int _amountData = 0;
  String _dateData = "";

  bool isLoading = false;

  final db = FirebaseFirestore.instance.collection("expense calculator");

  bool _incomeSelected = false;
  bool _expenseSelected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_tag),
        ),
        body: Form(
          key: _keyForm,
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    addNameTextFieldWidget(),
                    Visibility(
                      visible: isExpenseError,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          "Please enter name",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    addExpenseTextFieldWidget(),
                    Visibility(
                      visible: isExpenseError,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          "Please enter amount",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    addIncomeOrExpense(),
                    const SizedBox(height: 10),
                    addDateWidget(context),
                    const SizedBox(height: 15),
                    addExpenseButton(),

                  ])),
        ),
      ),
    );
  }

  addNameTextFieldWidget() => Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Enter name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isNameError = true;
          });
        } else {
          setState(() {
            isNameError = false;
          });
          _nameData = value.toString();
          return null;
        }
      },
    ),
  );

  addExpenseTextFieldWidget() => Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      obscureText: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Enter amount",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isExpenseError = true;
          });
        } else {
          setState(() {
            isExpenseError = false;
          });
        }
        _amountData = int.parse(value);
        return null;
      },
    ),
  );

  addIncomeOrExpense() => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: Row(
      children: [
        ChoiceChip(
            selected: _incomeSelected,
            label: const Text("income",),
            selectedColor: Colors.green,
            backgroundColor: Colors.black.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 10),
            onSelected: (bool selected) {
              setState(() {
                _incomeSelected = !_incomeSelected;
                if (_incomeSelected) {
                  _expenseSelected = false;
                }
              });
            }),
        const SizedBox(width: 10),
        ChoiceChip(
            selected: _expenseSelected,
            label: const Text("expense",),
            selectedColor: Colors.green,
            backgroundColor: Colors.black.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 10),
            onSelected: (bool selected) {
              setState(() {
                _expenseSelected = !_expenseSelected;
                if (_expenseSelected) {
                  _incomeSelected = false;
                }
              });
            }),
      ],
    ),
  );

  addDateWidget(BuildContext context) => GestureDetector(
    onTap: (){
      selectDate(context);
    },
    child: Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.1)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
            onPressed: () {
              selectDate(context);
            },
            icon: const Icon(Icons.date_range_outlined)),
        Text("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}")
      ]),
    ),
  );

  addExpenseButton()=>  Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: ElevatedButton(
      onPressed: () async {
        var isValid = _keyForm.currentState!.validate();
        if (!isValid) {
          return;
        }
        else if(!_incomeSelected && !_expenseSelected){
          toast("Please select type of amount.");
          return;
        }
        else {
          _dateData = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

          debugPrint("name: ${_nameData}");
          debugPrint("amount: ${_amountData}");
          debugPrint("date: ${_dateData}");

          // var data= ExpenseDataModel(
          //     name: _nameData,
          //     amount: _amountData,
          //     date: _dateData);

          if (_incomeSelected) {
            db.add({
              "name": _nameData,
              "amount": _amountData,
              "type": 1,
              "date": _dateData
            }).then((value) => Navigator.pop(context))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          } else {
            db.add({
              "name": _nameData,
              "amount": _amountData,
              "type": 0,
              "date": _dateData
            }).then((value) => Navigator.pop(context))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          }


          eventBus.fire(DataEvent(expenseData: 1));

          // getTotal();
        }
      },
      child: isLoading
          ? const CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      )
          : const Text(
        "Add Expense",
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
    ),
  );

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        debugPrint("day: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");
        _dateData = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }


// getTotal() async {
//
//   dynamic total = 0;
//
//   dynamic income=0;
//   dynamic expense=0;
//
//   final expenseCal = Provider.of<ExpenseDataCalculationProvider>(context, listen: false);
//
//   await db.get().then((value) {
//     for (var element in value.docs) {
//       // counter += element["amount"];
//       if(element["type"] == 1){
//         total +=element["amount"];
//         income +=element["amount"];
//
//         expenseCal.setTotalValue(total);
//         expenseCal.setIncomeValue(income);
//
//       }else{
//         total -=element["amount"];
//         expense+=element["amount"];
//       }
//     }
//   });
//
//   setState(() {
//     this.total=total;
//     this.income=income;
//     this.expense=expense;
//   });
//
// }


}

void toast(String s) {
}

class DataEvent {
  int? expenseData;
  DataEvent({this.expenseData});
}
