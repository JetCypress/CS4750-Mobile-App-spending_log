import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spending_log/screens/calendar_screen.dart';
import 'package:spending_log/data/transaction_data.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("transaction_database");

  //start app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyCalendarApp(),
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        ),
    );
  }
}