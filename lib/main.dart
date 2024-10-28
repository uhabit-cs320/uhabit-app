import 'package:UHabit/SettingsScreen.dart';
import 'package:flutter/material.dart';
import 'UserScreen.dart';
import 'CalendarScreen.dart';
import 'HomeScreen.dart';
import 'FriendScreen.dart';
import 'AppBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _selectedIndex = 0;
  String _screenTitle = 'Home';
  var _screenTitles = ['Home', 'Friends', 'Calendar', 'You', 'Settings'];

  // This method handles updating the selected index when a bottom navigation item is tapped.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _screenTitle = _screenTitles[index];
    });
  }

  // This list of widgets is used to navigate between the main content and the UserScreen.
  final List<Widget> _pages = [
    HomeScreen(),
    FriendScreen(),
    CalendarScreen(),
    UserScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _screenTitle),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[400],
        // Light green color for selected icon
        unselectedItemColor: Colors.green[400],
        // Light green color for unselected icons
        onTap: _onItemTapped,
        // Update index on item tap
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive), label: 'Friends'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'You'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
