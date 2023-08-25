import 'package:flutter/material.dart';

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donasi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih jenis donasi:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            DonationOptionCard(
              category: 'Kategori 1',
              description: 'Deskripsi kategori 1.',
            ),
            DonationOptionCard(
              category: 'Kategori 2',
              description: 'Deskripsi kategori 2.',
            ),
            // Add more DonationOptionCard widgets for other categories
          ],
        ),
      ),
    );
  }
}

class DonationOptionCard extends StatelessWidget {
  final String category;
  final String description;

  DonationOptionCard({
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle donation option selection here
        // You can navigate to the donation form or other pages
        // based on the selected category.
        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DonationFormPage(category: category))),
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Donation(),
  ));
}
