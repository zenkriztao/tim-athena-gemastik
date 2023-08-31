// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

import 'package:aksonhealth/theme.dart';
import 'package:aksonhealth/view/parents/home/home_screen.dart';

class NST extends StatefulWidget {
  @override
  _NSTState createState() => _NSTState();
}

class _NSTState extends State<NST> {
  List<List<int>> gridData = [];
  int answer = 1;
  int answerRight = 0;
  int answerWrong = 0;

  List<int> angkaList = List.generate(36, (index) => index + 1);
  int? angkaAcak;

  void generateRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(angkaList.length);
    setState(() {
      angkaAcak = angkaList[randomNumber];
    });
  }

  final audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    generateGrid();
    angkaAcak = Random().nextInt(36) + 1;
    audioPlayer.play(AssetSource('backsound.mp3'));
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    // audioPlayer.play('backsound.mp3', isLocal: true);
  }

  void generateGrid() {
    List<int> numbers = List.generate(36, (index) => index + 1);
    numbers.shuffle();

    gridData.clear();
    for (int i = 0; i < 6; i++) {
      gridData.add(numbers.sublist(i * 6, (i + 1) * 6));
    }
  }

  void randomizeGrid() {
    setState(() {
      generateGrid();
      angkaAcak = Random().nextInt(36) + 1;
    });
  }

  void showSnackBar() {
    QuickAlert.show(
      text: 'Pilihan kamu benar',
      title: 'Selamat!',
      context: context,
      type: QuickAlertType.custom,
      customAsset: 'assets/nst/congrats.png',
      widget: SizedBox(),
      confirmBtnColor: Colors.green,
      confirmBtnText: 'Lanjut',
      // onConfirmBtnTap: () {},
    );
  }

  void showSnackBarFailed() {
    QuickAlert.show(
      text: 'Pilihan kamu salah',
      title: 'Gagal',
      context: context,
      type: QuickAlertType.custom,
      customAsset: 'assets/nst/wrong2.png',
      widget: SizedBox(),
      confirmBtnColor: Colors.red,
      confirmBtnText: 'Coba lagi',
      // onConfirmBtnTap: () {},
    );
  }

  void showSnackBarResult() {
    QuickAlert.show(
      text: '$answerRight jawaban kamu benar',
      title: 'Berakhir',
      context: context,
      type: QuickAlertType.custom,
      customAsset: 'assets/nst/result.png',
      widget: SizedBox(),
      confirmBtnColor: Colors.green,
      confirmBtnText: 'Selesai',
    );
  }

  void funHomeActive() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text(
                'Pilih gambar yang cocok',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Image.asset(
                  'assets/nst/$angkaAcak.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Text(
                '${answer}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemCount: gridData.length * 6,
                  itemBuilder: (context, index) {
                    int row = index ~/ 6;
                    int col = index % 6;
                    String imagePath = 'assets/nst/${gridData[row][col]}.png';
                    return GestureDetector(
                      onTap: () {
                        if (gridData[row][col] == angkaAcak && answer == 10) {
                          answerRight++;
                          showSnackBarResult();
                          randomizeGrid();

                          answer = 1;
                          answerRight = 0;
                          answerWrong = 0;
                        } else if (answer == 10) {
                          showSnackBarResult();
                          randomizeGrid();
                          answer = 1;
                          answerRight = 0;
                          answerWrong = 0;
                        } else if (gridData[row][col] == angkaAcak) {
                          showSnackBar();
                          randomizeGrid();
                          answerRight++;
                          answer++;
                        } else {
                          showSnackBarFailed();
                          randomizeGrid();
                          answerWrong++;
                          answer++;
                        }

                        print('Answerd: $answer');
                        print('Right: $answerRight');
                        print('Wrong: $answerWrong');
                      },
                      child: GridTile(
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              imagePath,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.red[400]!;
                return Colors.red[300]!;
              },
            ),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            overlayColor: MaterialStateProperty.all(Colors.yellow[100]),
            elevation: MaterialStateProperty.all(5),
            shadowColor: MaterialStateProperty.all(Colors.yellow[700]),
          ),
          child: Text(
            'Kembali',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            audioPlayer.stop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Kamu ingin keluar aplikasi?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: greenColor,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                    primary: redColor,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
