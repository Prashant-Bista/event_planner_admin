
import 'package:event_planner_admin/Pages/data_page.dart';
import 'package:event_planner_admin/Pages/home_page.dart';
import 'package:event_planner_admin/Pages/venue_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic>? genRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return MaterialPageRoute(builder: (context) => Home());
    }
    if (settings.name =="/login") {
      // return MaterialPageRoute(builder: (context)=>Login());
    }
    if(settings.name =="/venue"){
      return MaterialPageRoute(builder: (context)=>VenueScreen());
    }
    if(settings.name =="/data"){
      return MaterialPageRoute(builder: (context)=>DataPage());
    }
  }
}
