import 'package:event_planner_admin/components.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    int barIndex = 0;

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
        title: Text("Home"),
      ),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            HomeTile(
                icon: Icon(Icons.store),
                name: "Venues",
                onpressed: () {
                  Navigator.of(context).pushNamed("/venue");
                }),
            HomeTile(
              onpressed: () {
                Navigator.of(context).pushNamed("/venue");
              },
              name: "Users",
              icon: Icon(Icons.supervised_user_circle_rounded),
            ),
            HomeTile(
              onpressed: () {
                Navigator.of(context).pushNamed("/data");
              },
              name: "Data",
              icon: Icon(Icons.dataset_sharp),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: barIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Venue"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dataset_sharp), label: "Data")
        ],
        onTap: (index) {
          barIndex = index;
          if (barIndex == 0) {
            Navigator.of(context).pushNamed("/venue");
          } else if (barIndex == 1) {
            Navigator.of(context).pushNamed("/venue");
          } else if (barIndex == 2) {
            Navigator.of(context).pushNamed("/data");
          }
        },
      ),
    );
  }
}
