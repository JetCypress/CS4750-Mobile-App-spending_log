import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_log/data/transaction_data.dart';
import 'package:spending_log/models/transaction_item.dart';
import 'package:spending_log/screens/add_Transaction_Screen.dart';
import 'package:spending_log/widgets/transaction_list.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({super.key, required this.selectedDay});
  final DateTime selectedDay;
  @override
  State<DayScreen> createState() => DayScreenState();
}



class DayScreenState extends State<DayScreen> {
  double dailySpending = 0.00;

  @override
  Widget build(BuildContext context){
    void deleteTransaction(TransactionItem transaction) {
      Provider.of<TransactionData>(context, listen: false).deleteTransaction(transaction);
    }
    return Consumer<TransactionData>(
        builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              dailySpending = Provider.of<TransactionData>(context, listen: false).calculateDailyTransactionSummary(widget.selectedDay);
              Navigator.of(context).pop(dailySpending);
            }
          ),
          title: Text("${widget.selectedDay.month} / ${widget.selectedDay.day} / ${widget.selectedDay.year}", style: const TextStyle(color: Colors.white, fontSize: 40)),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),

        body:
            ListView.builder(
              itemCount: value.getAllTransactionList().length,
              itemBuilder: (context, index) {
              if (value.getAllTransactionList()[index].dateTime.day ==
                    widget.selectedDay.day) {
                return TransactionList(
                    name: value.getAllTransactionList()[index].name,
                    amount: value.getAllTransactionList()[index].amount,
                    dateTime: value.getAllTransactionList()[index].dateTime,
                    deleteTapped: (p0) => deleteTransaction(value.getAllTransactionList()[index]),
                  );
                }
              }
            ),


        floatingActionButton: FloatingActionButton(
        onPressed:  () =>
        {Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyTransaction(selectedDay: widget.selectedDay)
            ),
          ),
        },

        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
        ),
      )
    );
  }
}