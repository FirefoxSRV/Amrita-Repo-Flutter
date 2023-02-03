import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2dfd1),
      body: Center(child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2,)),
    );
  }
}
