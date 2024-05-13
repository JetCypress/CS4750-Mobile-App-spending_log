import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spending_log/data/transaction_data.dart';
import 'package:spending_log/models/transaction_item.dart';

class MyTransaction extends StatefulWidget {
  const MyTransaction({super.key, required this.selectedDay});
  final DateTime selectedDay;
  @override
  State<MyTransaction> createState() => AddTransactionScreen();
}

class AddTransactionScreen extends State<MyTransaction> {

  final newTransactionNameController = TextEditingController();
  final newTransactionDollarController = TextEditingController();
  final newTransactionCentsController = TextEditingController();


  void save() {
    //Formats the cents to be 2 decimal places
    String cents = newTransactionCentsController.text;
    if (cents.isEmpty) {
      cents = '00';
    }
    if (cents.length == 1) {
      cents = '0' + cents;
    }

    //Fills in the Dollars with 0 if it is empty
    String dollars = newTransactionDollarController.text;
    if (dollars.isEmpty) {
      dollars = '0';
    }

    //combines the dollars and cents
    String amount = dollars + '.' + cents;

    //checks if the fields are filled out
    if (newTransactionNameController.text.isNotEmpty) {

      //creates a TransactionItem
      TransactionItem newTransaction = TransactionItem(
          name: newTransactionNameController.text,
          amount: amount,
          dateTime: widget.selectedDay);
      Provider.of<TransactionData>(context, listen: false).addNewTransaction(newTransaction);
    }
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction', style: TextStyle(color: Colors.white, fontSize: 40)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: content(),
    );
  }

  Widget content() {
    return ListView (
      children: <Widget> [
        //Transaction Name
        TextField(
          controller: newTransactionNameController,
          style:const TextStyle(fontSize:25),
          decoration: const InputDecoration(
            hintText: "Transaction Name"
          )
        ),

        Row( children:[
          Expanded(
            child: TextField(
              controller: newTransactionDollarController,
              style:const TextStyle(fontSize:25),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Dollars"
              )
            ),
          ),

          Expanded(
            child: TextField(
              controller: newTransactionCentsController,
              style:const TextStyle(fontSize:25),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                hintText: "Cents"
              )
            ),
          ),
        ]),


        MaterialButton(
          onPressed: save,
          child: const Text('Save', style:TextStyle(fontSize:25)),
        ),

        MaterialButton(
          onPressed: cancel,
          child: const Text('Cancel', style:TextStyle(fontSize:25)),
        ),
      ],
    );
  }
}