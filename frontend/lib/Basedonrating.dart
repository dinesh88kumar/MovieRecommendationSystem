import 'package:flutter/material.dart';

class BasedOnRating extends StatefulWidget {
  const BasedOnRating({Key? key}) : super(key: key);

  @override
  _BasedOnRatingState createState() => _BasedOnRatingState();
}

class _BasedOnRatingState extends State<BasedOnRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('based on Rating')),
    );
  }
}
