import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner_admin/Pages/data_page.dart';
import 'package:event_planner_admin/Pages/home_page.dart';
import 'package:event_planner_admin/Pages/venue_screen.dart';
import 'package:event_planner_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_admin/route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Use super.key here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Event Planner Admin Panel',
      theme: ThemeData(
        appBarTheme: AppBarTheme(

          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 32),
            backgroundColor: Colors.purpleAccent
        ),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      onGenerateRoute: (setting)=>Routes.genRoute(setting),
    );

  }
}

