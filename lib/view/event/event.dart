import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Event')),
        body: HorizontalGrid(),
      ),
    );
  }
}

class HorizontalGrid extends StatelessWidget {
  final List<Map<String, dynamic>> gridData = [
    {
      'imagePath': 'assets/images/campaign.png',
      'title': 'Title 1',
      'text': 'test',
    },
    {
      'imagePath': 'assets/images/campaign.png',
      'title': 'Title 2',
      'text': 'test',
    },
    {
      'imagePath': 'assets/images/campaign.png',
      'title': 'Title 3',
      'text': 'test',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: gridData.map((data) {
        return GridItem(
          imagePath: data['imagePath'],
          title: data['title'],
          text: data['text'],
        );
      }).toList(),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String text;

  GridItem({required this.imagePath, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 200, // Adjust the width as needed
        color: Colors.white,
        child: Container(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 200,
                width: 100,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 8),
              Text(title, maxLines: 2, textAlign: TextAlign.start),
              SizedBox(height: 8),
              Text(text, maxLines: 2, textAlign: TextAlign.start),
              SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                child: Text('Ayo Gabung'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}