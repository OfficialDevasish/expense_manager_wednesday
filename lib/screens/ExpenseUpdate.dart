import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:intl/intl.dart';

import '../helpers/DataBaseHandler.dart';
import 'ExpenseMangerHomePage.dart';



class ExpenseUpdate extends StatefulWidget {
  var updateid;
  ExpenseUpdate({this.updateid});


  @override
  State<ExpenseUpdate> createState() => _ExpenseUpdateState();
}

class _ExpenseUpdateState extends State<ExpenseUpdate> {

  TextEditingController _head = TextEditingController();
  TextEditingController _descp = TextEditingController();
  TextEditingController _ammount = TextEditingController();




  String time = '?';

  var _typ="income";
  TextEditingController _date = TextEditingController();

  getupdatedata()async
  {
    DatabaseHandler obj = DatabaseHandler();
    var updatedata = await obj.getsingleExpense(widget.updateid);
    setState(() {
      _head.text = updatedata[0]["expense_head"].toString();
      _descp.text = updatedata[0]["descp"].toString();
      _typ = updatedata[0]["typ"].toString();
      _ammount.text = updatedata[0]["amount"].toString();
      _date.text = updatedata[0]["dat"].toString();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getupdatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: const Center(
          child: Text("Update"),
        ),
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
                  TextField(
                    controller: _descp,
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

                      const SizedBox(width: 80,),

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

                  const Text("AMMOUNT:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _ammount,
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
                  const Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                        ElevatedButton(
                            onPressed: ()async {
                              var datePicked = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: DateTime(2022),
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
                            child: const Icon(Icons.calendar_today_outlined))
                      ]
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child:  ElevatedButton(
                      onPressed: (){
                        var head =_head.text.toString();
                        var descp = _descp.text.toString();
                        var typ = _typ.toString();
                        var amount = _ammount.text.toString();
                        var dat = _date.text.toString();

                        DatabaseHandler obj = DatabaseHandler();

                        obj.saveexpense(head,descp,typ,amount,dat,widget.updateid);

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>ExpenseMangerHomePage())
                        );

                      },




                      child: const Text("Update",style: TextStyle(fontSize: 20,color:Colors.white),),
                    ),
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