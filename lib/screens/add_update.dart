import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../firebase_expense_calculator/expense_data_model.dart';
import 'add_expense.dart';
import 'expense_calculator_screen.dart';





class AddUpdateExpenseScreen extends StatefulWidget {
  const AddUpdateExpenseScreen(
      {Key? key,
        required this.isUpdate,
        required this.id,
        required this.expenseDataModel})
      : super(key: key);

  final bool isUpdate;
  final String id;
  final ExpenseDataModel expenseDataModel;

  @override
  State<AddUpdateExpenseScreen> createState() => _AddUpdateExpenseScreenState();
}

class _AddUpdateExpenseScreenState extends State<AddUpdateExpenseScreen> {

  final db = FirebaseFirestore.instance.collection("expense calculator");

  final keyForm = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var amountController = TextEditingController();

  String _nameData = "";
  double _amountData = 0.00;
  bool _incomeSelected = false;
  bool _expenseSelected = true;

  // DateTime selectedDate = DateTime.now();
  var selectedDate;

  bool isNameError = false;
  bool isExpenseError = false;

  bool isLoading = false;

  int year=0;
  int month=0;
  int day=0;

  get eventBus => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {

      nameController.text = widget.expenseDataModel.name.toString();
      amountController.text = widget.expenseDataModel.amount.toString();

      if (widget.expenseDataModel.type == 1) {
        _incomeSelected = true;
        _expenseSelected = false;
      }

      selectedDate = widget.expenseDataModel.date.toString();

      convertToDate(selectedDate);

    } else {
      selectedDate = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: widget.isUpdate ?  Text(ExpenseCalculatorListScreen().updateExpense) :  Text(ExpenseCalculatorListScreen().addExpense)),        body: Form(
          key: keyForm,
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    addNameTextFieldWidget(),
                    Visibility(
                      visible: isNameError,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "Please enter name",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    addAmountTextFieldWidget(),
                    Visibility(
                      visible: isExpenseError,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "Please enter amount",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    addIncomeOrExpense(),
                    const SizedBox(height: 10),
                    addDateWidget(context),
                    const SizedBox(height: 15),
                    widget.isUpdate
                        ? updateExpenseButton(context)
                        : addExpenseButton(context),
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
      controller: nameController,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Enter name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        debugPrint("value: ---->$value");
        if (value!.isEmpty) {
          debugPrint("value: isEmpty---->$value");
          setState(() {
            isNameError = true;
          });
        }
        else {
          debugPrint("value: else  ---->$value");
          setState(() {
            isNameError = false;
          });
          _nameData = value.toString();
          return null;
        }
      },
    ),
  );

  addAmountTextFieldWidget() => Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      controller: amountController,
      obscureText: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Enter amount",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isExpenseError = true;
          });
        } else {
          setState(() {
            isExpenseError = false;
          });
          _amountData = double.parse(value);
          return null;
        }
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
            label: const Text(
              "income",
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.black.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
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
            label: Text(
              "expense",
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.black.withOpacity(0.1),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
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
    onTap: () {
      selectDate(context);
    },
    child: Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.1)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
            onPressed: () {
              selectDate(context);
            },
            icon: Icon(Icons.date_range_outlined)),
        Text("$selectedDate")
      ]),
    ),
  );

  addExpenseButton(BuildContext context) => Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: ElevatedButton(
      onPressed: () async {
        var isValid = keyForm.currentState?.validate();

        if (isExpenseError || isNameError) {
          return;
        } else if (!_incomeSelected && !_expenseSelected) {
          toast("Please select type of amount.");
          return;
        } else {

          debugPrint("----Add:----");
          debugPrint("_nameData: ${_nameData}");
          debugPrint("_amountData: ${_amountData}");
          debugPrint("_incomeSelected: ${_incomeSelected}");
          debugPrint("_expenseSelected: ${_expenseSelected}");
          debugPrint("_dateData: ${selectedDate}");

          if (_incomeSelected) {
            db
                .add({
              "name": _nameData,
              "amount": _amountData,
              "type": 1,
              "date": selectedDate
            })
                .then((value) => Navigator.pop(context))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          } else {
            db
                .add({
              "name": _nameData,
              "amount": _amountData,
              "type": 0,
              "date": selectedDate
            })
                .then((value) => Navigator.pop(context))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          }

          eventBus.fire(DataEvent(expenseData: 1));

        }

      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
      child: isLoading
          ? const CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.white)
          : Text(
        "Add Expense",
      ),
    ),
  );

  updateExpenseButton(BuildContext mContext) => Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: ElevatedButton(
      onPressed: () async {
        var isValid = keyForm.currentState?.validate();
        if (isExpenseError || isNameError) {
          return;
        } else if (!_incomeSelected && !_expenseSelected) {
          toast("Please select type of amount.");
          return;
        } else {

          debugPrint("----update:----");
          debugPrint("id: ${widget.id}");
          debugPrint("_nameData: ${_nameData}");
          debugPrint("_amountData: ${_amountData}");
          debugPrint("_incomeSelected: ${_incomeSelected}");
          debugPrint("_expenseSelected: ${_expenseSelected}");
          debugPrint("_dateData: ${selectedDate}");

          if (_incomeSelected) {
            db
                .doc(widget.id)
                .update({
              "name": _nameData,
              "amount": _amountData,
              "type": 1,
              "date": selectedDate
            })
                .then((value) => Navigator.pop(mContext))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          } else {
            db
                .doc(widget.id)
                .update({
              "name": _nameData,
              "amount": _amountData,
              "type": 0,
              "date": selectedDate
            })
                .then((value) => Navigator.pop(mContext))
                .onError((error, stackTrace) =>
                debugPrint("something went wrong."));
          }

          eventBus.fire(DataEvent(expenseData: 1));
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
      child: isLoading
          ? const CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      )
          : Text(
        "Update Expense",
      ),
    ),
  );

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.isUpdate ? DateTime(year,month,day) : DateTime.now() ,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (picked != null /*&& picked != selectedDate*/) {
      setState(() {
        selectedDate = "${picked.day}-${picked.month}-${picked.year}";

        // debugPrint(
        //     "day: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}");

        // _dateData=_selectedDate;

        // _dateData = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

      });
    }

  }

  convertToDate(String date){
    var list = date.split("-");
    debugPrint("0 :${list[0]}");
    debugPrint("1: ${list[1]}");
    debugPrint("2: ${list[2]}");

    day = int.parse(list[0]);
    month =int.parse(list[1]) ;
    year =int.parse(list[2]);
  }

  backPressed(BuildContext mContext)=> Navigator.pop(mContext);

}
