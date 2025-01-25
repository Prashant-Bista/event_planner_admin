import 'package:event_planner_admin/Logics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataPage extends ConsumerWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    int barIndex=2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MaterialButton(onPressed: (){},child: Text("Delete Irrelevant Data"),color: Colors.red,),
            MaterialButton(onPressed: (){
              provider.getCSV();
            },child: Text("Download Data as CSV"),color: Colors.red,)],
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
