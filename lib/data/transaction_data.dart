import 'package:spending_log/data/hive_database.dart';
import "package:spending_log/models/transaction_item.dart";
import 'package:flutter/material.dart';

class TransactionData extends ChangeNotifier {
  // list of all transactions
  List<TransactionItem> overallTransactionList = [];

  // get transaction list
  List<TransactionItem> getAllTransactionList() {
    return overallTransactionList;
  }

  //prepare data from box
  final db = HiveDataBase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallTransactionList = db.readData();
    }
  }

  // add new transaction
  void addNewTransaction(TransactionItem newTransaction) {
    overallTransactionList.add(newTransaction);
    notifyListeners();
    db.saveData(overallTransactionList);
  }

  // delete transaction
  void deleteTransaction(TransactionItem transaction) {
    overallTransactionList.remove(transaction);
    notifyListeners();
    db.saveData(overallTransactionList);
  }

  //daily transaction summary
  double calculateDailyTransactionSummary(DateTime day) {
    Map<String, double> dailyTransactionSummary = {};
    for (var transaction in overallTransactionList) {
      String date = transaction.dateTime.year.toString()
          + transaction.dateTime.month.toString()
          + transaction.dateTime.day.toString();
      double amount = double.parse(transaction.amount);

      if (dailyTransactionSummary.containsKey(date)) {
        double currentAmount = dailyTransactionSummary[date]!;
        currentAmount += amount;
        dailyTransactionSummary[date] = currentAmount;
      } else {
        dailyTransactionSummary.addAll({date: amount});
      }
    }
    String dayString = day.year.toString()
        + day.month.toString()
        + day.day.toString();
    return dailyTransactionSummary[dayString] ?? 0;
  }

  //monthly transaction summary
  double calculateMonthlyTransactionSummary(DateTime day) {
    Map<String, double> monthlyTransactionSummary = {};
    for (var transaction in overallTransactionList) {
      String date = transaction.dateTime.year.toString()
          + transaction.dateTime.month.toString();
      double amount = double.parse(transaction.amount);

      if (monthlyTransactionSummary.containsKey(date)) {
        double currentAmount = monthlyTransactionSummary[date]!;
        currentAmount += amount;
        monthlyTransactionSummary[date] = currentAmount;
      } else {
        monthlyTransactionSummary.addAll({date: amount});
      }
    }
    String dayString = day.year.toString()
        + day.month.toString();
    return monthlyTransactionSummary[dayString] ?? 0;
  }

}