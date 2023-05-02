import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/auth/homescreen.dart';
import 'package:facebook_clone/auth/navscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facebook_clone/widget/login_app_bar.dart';
import 'package:facebook_clone/auth/signup.dart';
import 'package:facebook_clone/auth/forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final validate = GlobalKey<FormState>();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final _formKey = GlobalKey<FormState>();
  String _email = "", _password = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Toggle password visibility
  bool _obscureText = true;

  void _validateAndSubmit() async {
    try {
      print('$_email and $_password before');
      // UserCredential user = await _auth.signInWithEmailAndPassword(
      //     email: _email, password: _password);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => NavScreen()),
      // );

      final CollectionReference membersCollection =
          FirebaseFirestore.instance.collection('members');
      final QuerySnapshot querySnapshot =
          await membersCollection.where('email', isEqualTo: _email).get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot member = querySnapshot.docs.first;
        final String savedPassword = member['password'];

        if (savedPassword == _password) {
          print('Login successful.');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavScreen(email: _email)),
          );
        } else {
          print('Incorrect password.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect Password'),
            ),
          );
        }
      } else {
        print('User not found.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
          ),
        );
      }
    } catch (e) {
      print('$_email and $_password again');
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: LoginAppBar()),
        body: Container(
            height: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: SingleChildScrollView(
              child: Form(
                key: validate,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 110,
                      // alignment: Alignment.centerLeft,
                    ),
                    Container(
                        width: double.infinity,
                        child: TextFormField(
                          onChanged: (value) => _email = value,
                          validator: (value) {
                            print(value);
                            RegExp regex = new RegExp(pattern.toString());
                            if (value == null || value.isEmpty) {
                              return 'Please enter your contact details';
                            } else if (!regex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Mobile number or email address',
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: Colors.grey[100],
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(height: 8),
                    // Enter password container
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (value) => _password = value,
                        obscureText: _obscureText,
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // Login Button
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                          width: double.infinity,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          child: TextButton(
                              child: Text('Log In',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                if (validate.currentState!.validate()) {
                                  _validateAndSubmit();
                                }
                              })),
                    ),
                    SizedBox(height: 25),
                    Container(
                        width: double.infinity,
                        height: 42,
                        child: Align(
                            child: TextButton(
                                child: Text('Forgotten password?',
                                    style: GoogleFonts.roboto(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                }))),
                    SizedBox(height: 25),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '  or  ',
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Create New Account
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                          width: double.infinity,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: TextButton(
                              child: Text('Create New Account',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()));
                              })),
                    ),
                  ],
                ),
              ),
            )));
  }
}
