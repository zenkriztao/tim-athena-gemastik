import 'package:flutter/material.dart';

class DonationCampaign {
  final String title;
  final String description;
  final String imageUrl;

  DonationCampaign({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autism Awareness Campaign',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DonationScreen(),
    );
  }
}

class DonationScreen extends StatelessWidget {
  final List<DonationCampaign> campaigns = [
    DonationCampaign(
      title: 'Support Autism Education',
      description: 'Help us provide education for children with autism.',
      imageUrl: 'https://www.communitycare.co.uk/wp_content/uploads/sites/7//2016/04/Fotolia_106551158_S.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autism Awareness Campaign'),
      ),
      body: ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          return DonationCard(campaign: campaigns[index]);
        },
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final DonationCampaign campaign;

  DonationCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            campaign.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  campaign.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add donation button logic here
                  },
                  child: Text('Donate Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
