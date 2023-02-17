import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_bus/event_bus.dart';
import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/expensehomepage.dart';
import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/expensethirdpage.dart';
import 'package:flutter/material.dart';
import '../../screens/add_expense.dart';


class ExpenseCalculatorListScreen extends StatefulWidget {

  const ExpenseCalculatorListScreen({Key? key}) : super(key: key);

  String get listOfExpenses => "";

  String get updateExpense => '';
  String get addExpense => '';

  @override
  State<ExpenseCalculatorListScreen> createState() =>
      _ExpenseCalculatorListScreenState();
}

class _ExpenseCalculatorListScreenState extends State<ExpenseCalculatorListScreen>  with SingleTickerProviderStateMixin{

  final db = FirebaseFirestore.instance.collection("Expense Manager");

  double total=0;
  double income=0;
  double expense=0;

  StreamSubscription<DataEvent>? streamSubscription;

  @override
  void initState() {
    // TODO: implement initState

    init();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      streamSubscription = EventBus().on<DataEvent>().listen((event) {
        if(event.expenseData == 1){
          debugPrint("event fired");
          getTotal();
        }
      });
    });


    super.initState();
  }

  void init() async{
    await getTotal();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title:   Text(ExpenseCalculatorListScreen().listOfExpenses)),
        body: mainScreen(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            // var expenseDataModel = ExpenseDataModel(title: "", amount: 0, type: 0, date: "");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => expensethirdpage(
                      // isUpdate: false,
                      // id: "0",
                      // expenseDataModel: ExpenseDataModel(title: '')),
                ),
                ),
            );
          },
          child: const Icon(Icons.add_circle),
        ),
      ),
    );
  }

  mainScreen(BuildContext mContext) => SingleChildScrollView(
    child: Column(
      children: [
        Card(
          elevation: 3,
          color: Colors.green,
          child: Column(
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  getTotal();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("Expense Manager",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$total \$",
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("  Income: $income \$",
                      style: const TextStyle(color: Colors.white)),
                  Text("Expense: $expense \$  ",
                      style: const TextStyle(color: Colors.white))
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
        // StreamBuilder(
        //   stream: db.snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         shrinkWrap: true,
        //         physics: const ClampingScrollPhysics(),
        //         itemCount: snapshot.data?.docs.length,
        //         itemBuilder: (context, index) {
        //           final data = snapshot.data?.docs[index];
        //           return Card(
        //             elevation: 3,
        //             child: ListTile(
        //               title: Text(snapshot.data?.docs[index]["date"]),
        //               subtitle: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const SizedBox(height: 7),
        //                   Text(" title: ${snapshot.data?.docs[index]["title"]}"),
        //                   const SizedBox(height: 6),
        //                   Text(" Amount: ${snapshot.data?.docs[index]["Amount"]}"),
        //                   const SizedBox(height: 7),
        //                 ],
        //               ),
        //               trailing: IconButton(
        //                   onPressed: () {
        //
        //                     debugPrint("onPressed: ");
        //
        //                     var typeData = snapshot.data?.docs[index]["type"];
        //                     var Amount = snapshot.data?.docs[index]["Amount"];
        //
        //                     var id = data?.id;
        //
        //                     var expenseDataModel = ExpenseDataModel(
        //                         title: snapshot.data?.docs[index]["title"],
        //                         amount: Amount,
        //                         type: typeData,
        //                         date: snapshot.data?.docs[index]["date"]);
        //
        //                     showDialog(
        //                       context: context,
        //                       builder: (BuildContext context) {
        //                         return SimpleDialog(
        //                           children: [
        //                             SimpleDialogOption(
        //                               onPressed: () {
        //                                 debugPrint("onPressed: ");
        //
        //                                 db.doc(data?.id).delete();
        //                                 getTotal();
        //                                 Navigator.pop(mContext);
        //
        //                               },
        //                               child: Row(children: const [
        //
        //                                 Icon(Icons.delete_forever),
        //                                 SizedBox(width: 25),
        //                                 Text("Delete",style: TextStyle(fontSize: 14))
        //
        //                                 // Expanded(
        //                                 //     flex: 1,
        //                                 //     child:
        //                                 //         Icon(Icons.delete_forever)),
        //                                 // Expanded(
        //                                 //     flex: 9,
        //                                 //     child: Text("      Delete",style: TextStyle(fontSize: 14))),
        //
        //                               ]),
        //                             ),
        //                             SimpleDialogOption(
        //                               onPressed: () {
        //                                 debugPrint("onPressed: ");
        //
        //                                 // var typeData = snapshot.data?.docs[index]["type"];
        //                                 // var amount = snapshot.data?.docs[index]["amount"];
        //
        //                                 // var id = data?.id;
        //
        //                                 // var expenseDataModel = ExpenseDataModel(
        //                                 //     name: snapshot.data?.docs[index]["name"],
        //                                 //     amount: amount,
        //                                 //     type: typeData,
        //                                 //     date: snapshot.data?.docs[index]["date"]);
        //
        //                                 Navigator.pop(context);
        //
        //                                 Navigator.push(
        //                                     context,
        //                                     MaterialPageRoute(
        //                                         builder: (con) =>
        //                                             AddUpdateExpenseScreen(
        //                                                 isUpdate: true,
        //                                                 id: id.toString(),
        //                                                 expenseDataModel:
        //                                                 expenseDataModel)
        //                                     )
        //                                 );
        //
        //
        //                               },
        //                               child: Row( children: const [
        //
        //                                 Icon(Icons.edit),
        //                                 SizedBox(width: 25),
        //                                 Text("Edit",style: TextStyle(fontSize: 14))
        //
        //
        //
        //                                 // Expanded(
        //                                 //     flex: 1,
        //                                 //     child: Icon(Icons.edit)),
        //                                 // Expanded(
        //                                 //   flex: 8,
        //                                 //   child: Text("      Edit",style: TextStyle(fontSize: 14),),
        //                                 // ),
        //                                 //
        //
        //                               ]),
        //                             ),
        //                           ],
        //                         );
        //                       },
        //                     );
        //                   },
        //                   icon: const Icon(Icons.more_vert)),
        //               // trailing: PopupMenuButton(
        //               //   icon: const Icon(Icons.more_vert),
        //               //   itemBuilder: (BuildContext mContext) => [
        //               //     PopupMenuItem(
        //               //         child: ListTile(
        //               //             onTap: () {
        //               //               // ref.child(snapshot.child("id").value.toString()).remove();
        //               //
        //               //               db.doc(data?.id).delete();
        //               //               getTotal();
        //               //               Navigator.pop(mContext);
        //               //
        //               //             },
        //               //             leading: Icon(Icons.delete),
        //               //             title: Text("delete"))),
        //               //     PopupMenuItem(
        //               //         child: ListTile(
        //               //             onTap: () {
        //               //               // ref.child(snapshot.child("id").value.toString()).update({"title": "${snapshot.child("title").value.toString()} - ${DateTime.now().millisecondsSinceEpoch.toString()}"});
        //               //
        //               //               var typeData = snapshot.data?.docs[index]["type"];
        //               //               var amount = snapshot.data?.docs[index]["amount"];
        //               //               var id = data?.id;
        //               //
        //               //               // db.doc("${data?.id}").update({
        //               //               //   "name": "${snapshot.data?.docs[index]["name"]}--Updated",
        //               //               //   "amount": amount,
        //               //               //   "type": typeData,
        //               //               //   "date": "${snapshot.data?.docs[index]["date"]}"
        //               //               // });
        //               //
        //               //               var expenseDataModel = ExpenseDataModel(
        //               //                   name: snapshot.data?.docs[index]["name"],
        //               //                   amount: amount,
        //               //                   type: typeData,
        //               //                   date: snapshot.data?.docs[index]["date"]);
        //               //
        //               //               // getTotal();
        //               //               // Navigator.pop(mContext);
        //               //
        //               //               Navigator.push(
        //               //                   mContext,
        //               //                   MaterialPageRoute(
        //               //                       builder: (con) =>
        //               //                           AddOrUpdateExpense(
        //               //                               isUpdate: true,
        //               //                               id: id.toString(),
        //               //                               expenseDataModel:
        //               //                                   expenseDataModel)));
        //               //
        //               //             },
        //               //             leading: const Icon(Icons.edit),
        //               //             title: const Text("edit"))),
        //               //   ],
        //               // ),
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return const Card(
        //         elevation: 3,
        //         child: ListTile(
        //           title: Text("noData"),
        //         ),
        //       );
        //     }
        //   },
        // ),
      ],
    ),
  );

  getTotal() async {

    var db = FirebaseFirestore.instance.collection("Expense Manager");




    await db.get().then((value) {
      log("value ${value.docs}");
      if (value.docs.isNotEmpty) {
        // print("output--->${value.exists}");
        debugPrint("docs.isNotEmpty");
        for (var element in value.docs) {
          print("type---> ${element.data()}");
          Map<String,dynamic> dataMap = element.data();
          // counter += element["amount"];
          if (dataMap["type"] == "income") {
            // total += element["amount"];
            // data.sink.add(total);
            income += double.parse(dataMap["amount"].toString());
          } else {
            // total -= element["amount"];
            // data.sink.add(total);
            expense += double.parse(dataMap["amount"].toString());
          }
        }
        // print("total----->$income,$expense");
      } else {
        debugPrint("docs.Empty");
        total = 0.00;
        income = 0.00;
        expense = 0.00;
      }
    });

    debugPrint("total:----->$total");
    debugPrint("income:----->$income");
    debugPrint("expense:----->$expense");

    setState(() {
      this.total = total;
      this.income = income;
      this.expense = expense;
    });

  }

}
