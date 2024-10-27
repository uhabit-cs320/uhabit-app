import 'package:UHabit/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserScreen.dart';
import 'CalendarScreen.dart';
import 'HomeScreen.dart';
import 'RecordScreen.dart';
import 'FriendScreen.dart';
import 'AppBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(MaterialApp(
    home: SignUpScreen(),
    debugShowCheckedModeBanner: false,
  ));
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
  var _screenTitles = ['Home', 'Calendar', 'Record', 'Friends', 'You'];

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
    CalendarScreen(),
    RecordScreen(),
    FriendScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _screenTitle),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],  // Light green color for selected icon
        unselectedItemColor: Colors.greenAccent[400], // Light green color for unselected icons
        onTap: _onItemTapped,                   // Update index on item tap
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.add_task), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.all_inclusive), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'You'),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}



