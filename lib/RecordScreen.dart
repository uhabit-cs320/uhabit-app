import 'package:flutter/material.dart';
import 'AppBar.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    labelColor: Colors.lightGreen,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.lightGreen,
                    tabs: [
                      Tab(text: 'Progress'),
                      Tab(text: 'Activities'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.directions_run, color: Colors.lightGreen),
                    label: Text('Run', style: TextStyle(color: Colors.lightGreen)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.lightGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This week',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Distance', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('0 km', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Time', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('0m', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Elev Gain', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('0 m', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(child: Text('Weekly Progress Chart Placeholder')),
                  ),
                  SizedBox(height: 16),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
