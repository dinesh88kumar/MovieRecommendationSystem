import 'package:flutter/material.dart';

class BasedOnLiked extends StatefulWidget {
  const BasedOnLiked({Key? key}) : super(key: key);

  @override
  _BasedOnLikedState createState() => _BasedOnLikedState();
}

class _BasedOnLikedState extends State<BasedOnLiked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('based on liked')),
    );
  }
}
