import 'package:flutter/material.dart';
import 'firebase_options.dart';
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
  final TextEditingController _placeController = TextEditingController();


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
              'place': _contactController.text,

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
class HomeTile extends StatelessWidget {
  Icon icon;
  String name;
  VoidCallback onpressed;
  HomeTile({super.key,required this.icon,required this.name, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    double deviceHeight= MediaQuery.of(context).size.height;
    double deviceWidth= MediaQuery.of(context).size.height;
    return MaterialButton(
      height: deviceHeight*0.25,
      minWidth: deviceWidth*0.3,
      splashColor: Colors.blue,
      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 10,
      color: Colors.red,
      onPressed: onpressed,child: Column(
      children: [
        icon,
        Text(name),
      ],
    ),);
  }
}

