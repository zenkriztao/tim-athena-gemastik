import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/donasi/donasi_payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationCampaign {
  final String title;
  final String description;
  final String validation;
  final String address;
  final String imageUrl;

  DonationCampaign({
    required this.title,
    required this.description,
    required this.validation,
    required this.address,
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
      title: 'Membantu Yayasan Autisme di Indonesia melalui Akson',
      description:
          'Selamat datang di kampanye donasi untuk mendukung Yayasan Autisme di Indonesia! Yayasan ini berkomitmen untuk meningkatkan pemahaman, dukungan, dan kualitas hidup bagi individu dengan spektrum autisme di seluruh negeri. Dengan memberikan sumbangan Anda, Anda turut berperan dalam mewujudkan perubahan positif dan inklusif bagi mereka yang membutuhkan.',
      validation: '',
      address: 'Jl. Srijaya Negara, Bukit Lama, Kec. Ilir Bar. I, Kota Palembang, Sumatera Selatan, Indonesia',
      imageUrl:
          'https://www.communitycare.co.uk/wp_content/uploads/sites/7//2016/04/Fotolia_106551158_S.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Peduli untuk mereka',
          style: GoogleFonts.nunito(),
        ),
        backgroundColor: darkBlueColor,
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
                  style: GoogleFonts.nunito(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  campaign.description,
                  style: GoogleFonts.nunito(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  campaign.address,
                  style: GoogleFonts.nunito(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CampaignProgress(),

                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(darkBlueColor)

                    ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonationPayment()));
                      },
                      child: Text("Donasi Sekarang", style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),)),
                )
              ],
            ),
          ),
        ],
      ),
    );
    
  }

 
}



class CampaignProgress extends StatelessWidget {
  final double currentProgress = 0.6; // Misalnya, 0.6 untuk 60% progress

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 50.0,
      child: CustomPaint(
        foregroundPainter: LinearProgressBarPainter(
          lineColor: Colors.grey,
          completeColor: Colors.green,
          completePercent: currentProgress,
          height: 20.0,
        ),
        child: Center(
          child: Text(
            '${(currentProgress * 100).toInt()}% dari Rp.100.000.000',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class LinearProgressBarPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double height;

  LinearProgressBarPainter({
    required this.lineColor,
    required this.completeColor,
    required this.completePercent,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = height;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = height;

    Offset startPoint = Offset(0, size.height / 2);
    Offset endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, line);

    double width = size.width * completePercent;

    canvas.drawLine(startPoint, Offset(width, size.height / 2), complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}