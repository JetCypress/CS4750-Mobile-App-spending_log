import 'package:flutter/material.dart';
import 'package:spending_log/screens/calendar_Screen.dart';
import 'package:spending_log/screens/list_Screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.brown,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Spending Log',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.format_list_bulleted, color: Colors.white, size: 50),
            title: const Text('List View', style: TextStyle(color: Colors.white, fontSize: 30)),
            onTap: () => {Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ListScreen()), (route) => false)},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month, color: Colors.white, size: 50),
            title: const Text('Calendar View', style: TextStyle(color: Colors.white, fontSize: 30)),
            onTap: () => {Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyCalendarApp()), (route) => false)},
          ),
        ],
      ),
    );
  }
}