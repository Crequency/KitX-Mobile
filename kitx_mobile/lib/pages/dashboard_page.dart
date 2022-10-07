import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
      ),
      body: const Center(
        child: Text(
          'DashBoardPage',
          style: TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
