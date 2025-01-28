import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Logics.dart';

class VenueScreen extends ConsumerWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Venues')),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Venues").snapshots(),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Error. Check Connection and try again."),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/venue");
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              List<String> venueIds= snapshot.data!.docs.map((doc)=>doc.id).toList();
              return ListView.builder(
                itemCount:snapshot.data!.docs.length ,
                itemBuilder: (context, index) {
                  DocumentSnapshot venue = snapshot.data!.docs[index];
                  return ListTile(
                    leading: SizedBox(
                        width: 200,
                        child: Image.network(venue["image_url"],fit: BoxFit.fill,)),
                    title: Text(venue['name']),
                    subtitle: Text(
                        'Capacity: ${venue['capacity']} | Price/Plate: Rs.${venue['price_per_plate']} | Location: ${venue["place"]}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.deleteVenue(venue.id,context),
                    ),
                    onTap: () => provider.updateVenue(venue.id,context)
                  );
                },
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          } catch (e) {
            print("Exception: $e");
            return Center(child: Text("An error occurred. Please try again."));
          }
        },
      )
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          provider.addVenue(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

