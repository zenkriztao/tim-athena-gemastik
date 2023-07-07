import 'package:aksonhealth/constants.dart';
import 'package:aksonhealth/view/parents/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:aksonhealth/view/specialists/doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportDetailScreen extends StatefulWidget {
  final String childName;
  final String childAge;
  final String childGender;
  final String date;
  final String childCase;
  final String childAdvice;
  final int total;

  const ReportDetailScreen({
    super.key,
    required this.childName,
    required this.childAge,
    required this.childGender,
    required this.childCase,
    required this.childAdvice,
    required this.date,
    required this.total,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          'Laporan',
          style: GoogleFonts.nunito(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.circular(5)

                  ),
              width: size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'Prediksi',
                  style: GoogleFonts.nunito(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                )),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 10.0,
              percent: widget.total / 10,
              center: new Text('${(widget.total / 10) * 100}' + '\%'),
              progressColor: widget.total <= 4
                  ? Colors.green
                  : widget.total > 4 && widget.total <= 6
                      ? Colors.yellow
                      : widget.total > 6
                          ? Colors.red
                          : Colors.blue,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: Container(
                width: size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tanggal',
                          style: GoogleFonts.nunito(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.58,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(DateTime.now()),
                          style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Nama Anak',
                        style: GoogleFonts.nunito(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.childName,
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Umur',
                        style: GoogleFonts.nunito(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      //border: Border.all(color: Colors.blue,width: 0.5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.childAge.toString() + ' tahun',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hasil',
                        style: GoogleFonts.nunito(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.total.toString() + ' / 10',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Prediksi',
                        style: GoogleFonts.nunito(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                            widget.total <= 4
                                ? 'Hasil ini menunjukkan risiko rendah autisme, tidak perlu membawa anak Anda ke dokter'
                                : widget.total > 4 && widget.total <= 6
                                    ? 'Hasil ini menunjukkan risiko autisme sedang, Anda diharuskan membawa anak Anda ke dokter untuk pemeriksaan lanjutan. Anda juga dapat mencari layanan intervensi dini untuk anak Anda di Aplikasi Akson.'
                                    : widget.total > 6
                                        ? 'Hasil ini menunjukkan risiko tinggi autisme, Anda wajib membawa anak Anda ke dokter untuk pemeriksaan lanjutan. Anda juga dapat mencari layanan intervensi dini untuk anak Anda di Aplikasi Akson'
                                        : 'Kalkulasi Autisme',
                            style: GoogleFonts.nunito(
                                color: widget.total <= 4
                                    ? Colors.green
                                    : widget.total > 4 && widget.total <= 6
                                        ? Colors.blue
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      fourColor,
                      fourColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(Size(size.width, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => SpecialistScreen(),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 100),
                        ),
                      );
                    },
                    child: Text('Tanyakan ke Dokter Akson', style: buttonStyle)),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
