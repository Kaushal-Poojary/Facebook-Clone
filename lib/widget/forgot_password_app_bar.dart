import 'package:flutter/material.dart';

class ForgotPasswordAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
