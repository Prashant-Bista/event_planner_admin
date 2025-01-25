import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'components.dart';
final stateProvider = ChangeNotifierProvider.autoDispose<BusinessLogic>((ref)=>BusinessLogic());
class BusinessLogic extends ChangeNotifier{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  
  void _addVenue() {
  }

  Future<void> _updateVenue(String venueId,BuildContext context) async{
    return showDialog(
      context: context,
      builder: (context) {
        return VenueDialog(
          venue: _db.collection("Venues").doc(venueId).get() as Map<String,dynamic>,
          onSave: (updatedVenue) async{
            await _db.collection("Venues").doc(venueId).update(
                {"capacity": updatedVenue["capacity"], "contact":updatedVenue["contact"], "image_url":updatedVenue["image"], "name":updatedVenue["name"], "price_per_plate":updatedVenue["price_per_plate"],});
          },
        );
      },
    );
  }

  void _deleteVenue(String venueId) {
    _db.collection("Venues").doc(venueId).delete();
  }
  Future<void> deteleData()async{
 QuerySnapshot userSnap= await _db.collection("Users").get();
 Set<String> userIds = userSnap.docs.map((snap)=>snap.id).toSet();
 List<String> eventIds=[];
QuerySnapshot eventSnap;
 for(int i =0;i<userIds.length;i++){
eventSnap= await _db.collection("Users").doc(userIds.elementAt(i)).collection("Events").where("presence",isEqualTo: false).where("expense",isEqualTo: 0).get();
 eventIds= eventSnap.docs.map((snap)=>snap.id).toList();
 for (String id in eventIds){
   await _db.collection("Users").doc(userIds.elementAt(i)).collection("Events").doc(id).delete();
 }
 }


  }
  Future<void> getCSV() async{
    try {
      QuerySnapshot userSnap = await _db.collection("Users").get();
      Set<String> userIds = userSnap.docs.map((snap) => snap.id).toSet();
      QuerySnapshot eventSnap;
      List<List<dynamic>> dataList = [["no_of_guests","venue_cost","no_of_tasks",	"no_of_vendors",	"budget(target)"]];
      List<dynamic> dataRow=[];
      for (String uid in userIds) {
        print("userid $uid");
        eventSnap =
        await _db.collection("Users").doc(uid).collection("Events").get();
        Map<String,dynamic> eventDetails;
        for (DocumentSnapshot docSnap in eventSnap.docs) {
          dataRow=[];
          eventDetails = docSnap.data() as Map<String,dynamic>;
          dataRow.add(eventDetails["guest_no"]);
          dataRow.add(eventDetails["venue_cost"]);
          dataRow.add(eventDetails["tasks_no"]);
          dataRow.add(eventDetails["vendors_no"]);
          dataRow.add(eventDetails["expense"]);
          dataList.add(dataRow);
          print(dataRow.toString());
//no_of_guests	venue_cost	no_of_tasks	no_of_vendors	budget(target)
        }
      }
      String csvData = ListToCsvConverter().convert(dataList);
      if(kIsWeb){
    final blob = html.Blob([csvData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)..target='blank'..download="event_data.csv";
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }
  else{
    final directory = await getApplicationDocumentsDirectory();

    final file  = File('${directory.path}/eventData.csv');
    print(file.path);
    await file.writeAsString(csvData);
  }

    }catch(e){
      print(e);
    }


  }

  }

