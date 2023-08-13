import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';

class CustomDoctorItem extends StatelessWidget {
  final String docName;
  final String docOccupation;
  final String description;
  final String hospitalName;
  final String address;
  final String trunkLine;
  final String website;
  final String gMapsLink;

  const CustomDoctorItem({
    super.key,
    required this.docName,
    required this.docOccupation,
    required this.description,
    required this.address,
    required this.trunkLine,
    required this.hospitalName,
    required this.website,
    required this.gMapsLink,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                docName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                docOccupation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    hospitalName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Telephone: $trunkLine',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(website));
                        },
                        child: Text('Go to website'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      FilledButton(
                        onPressed: () {
                          launchUrl(Uri.parse(gMapsLink));
                        },
                        child: const Text('Get Directions'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
