import 'package:flutter/material.dart';

class PhoneticList extends StatelessWidget {
  const PhoneticList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: Container(padding : EdgeInsets.all(10),
            child: Image.asset('assets/ABC/a.jpg'),),
          ),
          Card(
            child: Container(padding : EdgeInsets.all(10),
            child: Image.asset('assets/ABC/b.jpg'),),
          ),
          Card(
            child: Container(padding : EdgeInsets.all(10),
            child: Image.asset('assets/ABC/c.jpg'),),
          ),
          Card(
            child: Container(padding : EdgeInsets.all(10),
            child: Image.asset('assets/ABC/d.jpg'),),
          ),
        ],
      ),
    );
  }
}
