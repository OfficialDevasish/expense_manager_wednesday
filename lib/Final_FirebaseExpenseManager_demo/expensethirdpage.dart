import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/calculationpart/ExpenseCalculatorListScreen.dart';
import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/expensehomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:intl/intl.dart';




class expensethirdpage extends StatefulWidget {


  @override
  State<expensethirdpage> createState() => _expensethirdpageState();
}

class _expensethirdpageState extends State<expensethirdpage> {


  TextEditingController _head = TextEditingController();
  TextEditingController _descp = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _date = TextEditingController();



  String time = '?';

  var _typ="income";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.purple.shade400,
          title: const Center(
            child: Text("Transaction Entry"),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _head,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, ),
                      ),
                    ),

                    keyboardType: TextInputType.text,

                  ),
                  const SizedBox(height: 25,),
                  const Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _descp,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, ),
                      ),
                    ),

                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20,),
                  const Text("Type",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Row(
                    children: [

                      Radio(
                        activeColor: Colors.red,
                        value: "expense",
                        groupValue: _typ,
                        onChanged: (val){
                          setState(() {
                            _typ = val!;
                          });
                        },
                      ),
                      const Text("Expense:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      const SizedBox(width: 50,),
                      Radio(
                        activeColor: Colors.green,
                        value: "income",
                        groupValue: _typ,
                        onChanged: (val){
                          setState(() {
                            _typ = val!;
                          });
                        },
                      ),
                      const Text("Income:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  const Text("Amount:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _amount,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),


                  const SizedBox(height: 30,),
                  const Text("Transaction Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Stack(
                      alignment: const Alignment(1.0, 1.0),
                      children: <Widget>[
                        TextField(
                          controller: _date,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: ()async {
                              var datePicked = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: DateTime(2023),
                                firstDate: DateTime(1960),
                                lastDate: DateTime(2025),
                                dateFormat: "dd-MMMM-yyyy",
                                looping: true,
                              );
                              setState(() {
                                String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked!);
                                time=formattedDate.toString();
                                _date.text = time;
                              });
                            },
                            icon: const Icon(Icons.calendar_today_outlined)),
                      ]
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () {

                    var head =_head.text.toString();
                    FirebaseFirestore.instance
                        .collection('Expense Manager')
                        .add({'title': _head.text,'description' : _descp.text,'type':_typ,'amount' : _amount.text ,'created_date' : _date.text});
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                                  ExpenseCalculatorListScreen()));
                    },
                    child: const Text("Add",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ],
              ),

            ),

          ],

        ),

      ),

    );
  }
}