import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image(
          image: AssetImage('assets/facebook-icon.png'),
          height: 140,
          width: 140,
        ),
        centerTitle: true,
      ),
    );
  }
}
