import 'package:hive_flutter/hive_flutter.dart';

import '../models/transaction_item.dart';

class HiveDataBase {
  //reference the box
  final _myBox = Hive.box("transaction_database");

  //write data to the box
  void saveData(List<TransactionItem> allTransactions) {

    List<List<dynamic>> allTransactionsFormatted = [];
    for (var transaction in allTransactions){
      List<dynamic> transactionFormatted = [
        transaction.name,
        transaction.amount,
        transaction.dateTime,
      ];
      allTransactionsFormatted.add(transactionFormatted);
    }

    _myBox.put("ALL_TRANSACTIONS", allTransactionsFormatted);
  }

  //read data from the box
  List<TransactionItem> readData() {
    List savedTransactions = _myBox.get("ALL_TRANSACTIONS") ?? [];
    List<TransactionItem> allTransactions = [];

    for (int i = 0; i < savedTransactions.length; i++) {
      String name = savedTransactions[i][0];
      String amount = savedTransactions[i][1];
      DateTime dateTime = savedTransactions[i][2];

      TransactionItem transaction = TransactionItem(
          name: name,
          amount: amount,
          dateTime: dateTime
      );

      allTransactions.add(transaction);
    }
    return allTransactions;
  }

}