import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/auth/navscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facebook_clone/widget/signup_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:facebook_clone/auth/login.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

// Sign up page for facebook
class _SignupState extends State<Signup> {
  int? gender;
  TextEditingController _dateController = TextEditingController();
  final validate = GlobalKey<FormState>();

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  Pattern mobilePattern = r'^[0-9]{10}$';

  // Toggle password visibility
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _dateController.text = "";
  }

  DateTime? pickeddate = null;
  String _email = '', _password = "", f_name = "", l_name = "";


  void _createUser() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User account created successfully'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );

      // Store the password in encrypted form
      final key = encrypt.Key.fromUtf8('my 32 length key................');
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final encrypted = encrypter.encrypt(_password, iv: iv);
      _password = encrypted.base64;

      // Code to submit data to firebase
      await FirebaseFirestore.instance.collection('members').doc().set({
        'dob': pickeddate.toString(),
        'email': _email,
        'first_name': f_name,
        'gender': gender,
        'last_name': l_name,
        'password': _password,
      });
    } catch (e) {
      print('$_email and $_password again');
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // Creating 2 input fields for first and last name
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75), child: SignupAppBar()),
      body: Container(
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: SingleChildScrollView(
            child: Form(
              key: validate,
              child: Column(
                children: [
                  SizedBox(height: 35),
                  Container(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (value) => f_name = value,
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'First name',
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
                  // Enter Surname container
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      onChanged: (value) => l_name = value,
                      validator: (value) {
                        print(value);
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Surname',
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
                    ),
                  ),
                  SizedBox(height: 8),
                  // Enter Email container
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      onChanged: (value) => _email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact details';
                        } else {
                          RegExp emailRegex = new RegExp(pattern.toString());
                          RegExp mobileRegex =
                              new RegExp(mobilePattern.toString());
                          if (emailRegex.hasMatch(value) ||
                              mobileRegex.hasMatch(value)) {
                            return null;
                          } else {
                            return 'Please enter a valid email address or mobile number';
                          }
                        }
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
                    ),
                  ),
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
                        hintText: 'New password',
                        hintStyle: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        // Toggle password visibility icon
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
                  SizedBox(height: 8),
                  // Radio button for gender
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                }),
                            Expanded(
                              child: Text('Male'),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                }),
                            Expanded(child: Text('Female'))
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 2,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                }),
                            Expanded(child: Text('Custom'))
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Creating a date of birth container having date picker
                  TextField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter your date of birth",
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: pickeddate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat("yyyy-MM-dd").format(pickedDate);
                          setState(() {
                            _dateController.text = formattedDate.toString();
                            pickeddate = pickedDate;
                          });
                        } else {
                          print('No date selected');
                        }
                      }),
                  // Navigate to login page
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
                            child: Text('Sign Up',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              if (validate.currentState!.validate()) {
                                _createUser();
                              }
                            })),
                  ),
                  SizedBox(height: 8),
                  Container(
                      width: double.infinity,
                      height: 42,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              child: Text('Already have an account?',
                                  style: GoogleFonts.roboto(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              }))),
                ],
              ),
            ),
          )),
    );
  }
}
