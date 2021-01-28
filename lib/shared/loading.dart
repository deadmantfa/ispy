import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1f1f1f),
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xff145c9e),
          size: 50.0,
        ),
      ),
    );
  }
}
