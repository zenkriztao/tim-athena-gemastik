import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class NewPhoneticList extends StatelessWidget {
  NewPhoneticList({super.key});

  final player = AudioPlayer();

  // Function to generate a single card
  Widget generateCard(String letter) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          player.play(AssetSource('$letter.mp3'));
        },
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/icons8-$letter-100.png'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            13, // Number of rows (from 'a' to 'z' is 26 letters, 2 letters per row)
            (index) => Row(
              children: [
                generateCard(
                    String.fromCharCode(97 + index * 2)), // ASCII of 'a' is 97
                generateCard(
                    String.fromCharCode(98 + index * 2)), // ASCII of 'b' is 98
              ],
            ),
          ),
        ),
      ),
    );
  }
}
