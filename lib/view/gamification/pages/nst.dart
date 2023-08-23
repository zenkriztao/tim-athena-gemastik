import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

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

  @override
  void initState() {
    super.initState();
    generateGrid();
    angkaAcak = Random().nextInt(36) + 1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            FloatingActionButton(onPressed: () {
              answer = 9;
              print(answer);
            })
          ],
        ),
      ),
    );
  }
}
