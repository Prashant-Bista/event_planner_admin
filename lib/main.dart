import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Use super.key here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planner Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VenueScreen(),
    );
  }
}

class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key}); // Use super.key here

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  final List<Map<String, dynamic>> venues = [
    {
      'name': 'Grand Hall',
      'capacity': 500,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1200,
      'contact': '9801234567',
    },
    {
      'name': 'Sunshine Banquet',
      'capacity': 300,
      'image':
      'https://images.unsplash.com/photo-1508154048109-de555266b50a?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1000,
      'contact': '9809876543',
    },
    {
      'name': 'Urban Sphere',
      'capacity': 700,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1100,
      'contact': '9845612344',
    },
    {
      'name': 'Velvet Bloom',
      'capacity': 900,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1300,
      'contact': '9878451236',
    },
    {
      'name': 'Luxe Point',
      'capacity': 1500,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1700,
      'contact': '9845127894',
    },
    {
      'name': 'Crystal Haven',
      'capacity': 600,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 800,
      'contact': '984453194',
    },
    {
      'name': 'Azure Hall',
      'capacity': 800,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 1000,
      'contact': '9847541542',
    },
    {
      'name': 'Mosaic Venue',
      'capacity': 400,
      'image':
      'https://images.unsplash.com/photo-1571667872818-3d2eaf5d6dc5?auto=format&fit=crop&w=400&q=80',
      'pricePerPlate': 600,
      'contact': '9847845131',
    },
  ];

  void _addVenue() {
    showDialog(
      context: context,
      builder: (context) {
        return VenueDialog(
          onSave: (newVenue) {
            setState(() {
              venues.add(newVenue);
            });
          },
        );
      },
    );
  }

  void _updateVenue(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return VenueDialog(
          venue: venues[index],
          onSave: (updatedVenue) {
            setState(() {
              venues[index] = updatedVenue;
            });
          },
        );
      },
    );
  }

  void _deleteVenue(int index) {
    setState(() {
      venues.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Venues')),
      ),
      body: ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                venue['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(venue['name']),
              subtitle: Text(
                  'Capacity: ${venue['capacity']} | Price/Plate: Rs.${venue['pricePerPlate']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteVenue(index),
              ),
              onTap: () => _updateVenue(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addVenue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class VenueDialog extends StatefulWidget {
  final Map<String, dynamic>? venue;
  final void Function(Map<String, dynamic>) onSave;

  const VenueDialog({super.key, this.venue, required this.onSave}); // Use super.key here

  @override
  State<VenueDialog> createState() => _VenueDialogState();
}

class _VenueDialogState extends State<VenueDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.venue != null) {
      _nameController.text = widget.venue!['name'];
      _capacityController.text = widget.venue!['capacity'].toString();
      _imageController.text = widget.venue!['image'];
      _priceController.text = widget.venue!['pricePerPlate'].toString();
      _contactController.text = widget.venue!['contact'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.venue == null ? 'Add Venue' : 'Update Venue'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Venue Name'),
            ),
            TextField(
              controller: _capacityController,
              decoration: const InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price Per Plate'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Contact'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newVenue = {
              'name': _nameController.text,
              'capacity': int.parse(_capacityController.text),
              'image': _imageController.text,
              'pricePerPlate': int.parse(_priceController.text),
              'contact': _contactController.text,
            };
            widget.onSave(newVenue);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
