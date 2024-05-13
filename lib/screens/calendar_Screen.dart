import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spending_log/widgets/nav-drawer.dart';
import 'package:spending_log/screens/day_Screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spending_log/data/transaction_data.dart';
import 'package:provider/provider.dart';

class MyCalendarApp extends StatefulWidget {
  const MyCalendarApp({super.key});
  @override
  State<MyCalendarApp> createState() => CalendarScreen();
}

class CalendarScreen extends State<MyCalendarApp> {
  double monthlySpending = 0.00;
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  double dailySpending = 0.00;

  @override
  void initState() {
    super.initState();

    Provider.of<TransactionData>(context, listen: false).prepareData();
    refreshDailySpending();
    refreshMonthlySpending();
  }

  void refreshDailySpending() {
    dailySpending = Provider.of<TransactionData>(context, listen: false).calculateDailyTransactionSummary(selectedDate);
  }

  void refreshMonthlySpending() {
    monthlySpending = Provider.of<TransactionData>(context, listen: false).calculateMonthlyTransactionSummary(selectedDate);
  }

  FutureOr onGoBack() {
    refreshDailySpending();
    refreshMonthlySpending();
    setState((){});
  }

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      selectedDate = day;
      refreshDailySpending();
    });
  }

  void _onDayLongPressed(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDate = day;
      refreshDailySpending();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DayScreen(selectedDay: selectedDate),
        ),
      ).then((value) => onGoBack());
    });
  }

  void _onMonthSelected(DateTime day){
    setState(() {
      DateTime newMonth = day;
      selectedDate = newMonth;
      refreshDailySpending();
      refreshMonthlySpending();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Spending Log', style: TextStyle(color: Colors.white, fontSize: 40)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: content(),
    );
  }

  Widget content() {
    return Stack(
      children: [
        TableCalendar(
          locale: "en_US",
          headerStyle:
              const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, selectedDate),
          currentDay: today,
          focusedDay: selectedDate,
          firstDay: today.add(const Duration(days: -712)),
          lastDay: today.add(const Duration(days: 712)),
          onDaySelected: _onDaySelected,
          onDayLongPressed: _onDayLongPressed,
          onPageChanged: _onMonthSelected,

        ),

      Align(
        alignment: Alignment(0.0, 0.3),
        child: Text('Monthly Spending: \$'+monthlySpending.toStringAsFixed(2),
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      Align(
        alignment: Alignment(0.0, 0.6),
        child: Text("Day's Spending: \$"+dailySpending.toStringAsFixed(2),
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      ],
    );
  }
}