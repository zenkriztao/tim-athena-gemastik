import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class NewPhoneticList extends StatefulWidget {
  NewPhoneticList({super.key});

  @override
  _NewPhoneticListState createState() => _NewPhoneticListState();
}

class _NewPhoneticListState extends State<NewPhoneticList>
    with SingleTickerProviderStateMixin {
  final player = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to generate a single card
  Widget generateCard(String letter) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (details) {
          _controller.forward();
        },
        onTapUp: (details) async {
          _controller.reverse();
          await player.play(AssetSource('$letter.mp3'));
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/icons8-$letter-100.png'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('new phonetic list'),
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
