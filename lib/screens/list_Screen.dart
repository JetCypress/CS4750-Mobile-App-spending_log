import 'package:flutter/material.dart';
import 'package:spending_log/widgets/nav-drawer.dart';
import 'package:spending_log/data/transaction_data.dart';
import 'package:provider/provider.dart';
import '../models/transaction_item.dart';
import '../widgets/transaction_list.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  @override
  State<ListScreen> createState() => ListScreenState();
}



class ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context){
    void deleteTransaction(TransactionItem transaction) {
      Provider.of<TransactionData>(context, listen: false).deleteTransaction(transaction);
    }
    return Consumer<TransactionData>(
        builder: (context, value, child) => Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: const Text('List View', style: TextStyle(color: Colors.white, fontSize: 40)),
            backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          body:
          ListView.builder(
              itemCount: value.getAllTransactionList().length,
              itemBuilder: (context, index) {
                  return TransactionList(
                    name: value.getAllTransactionList()[index].name,
                    amount: value.getAllTransactionList()[index].amount,
                    dateTime: value.getAllTransactionList()[index].dateTime,
                    deleteTapped: (p0) => deleteTransaction(value.getAllTransactionList()[index]),
                  );
                }
          )
        ),
    );
  }
}