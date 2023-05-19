import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:facebook_clone/widget/forgot_password_app_bar.dart';
import 'package:facebook_clone/auth/login.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

// Forget password page
class _ForgotPasswordState extends State<ForgotPassword> {
  final validate = GlobalKey<FormState>();

  // Toggle password visibility
  bool _obscureText = true;
  bool _obscureTextNew = true;

  String _email = '', _password = "";

  void _resetPassword() async {
    try {
      final CollectionReference membersCollection =
          FirebaseFirestore.instance.collection('members');
      final QuerySnapshot querySnapshot =
          await membersCollection.where('email', isEqualTo: _email).get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Updated Successfully'),
          ),
        );
        final key = encrypt.Key.fromUtf8('my 32 length key................');
        final iv = encrypt.IV.fromLength(16);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));
        final encrypted = encrypter.encrypt(_password, iv: iv);
        _password = encrypted.base64;

        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await membersCollection
            .doc(documentSnapshot.id)
            .update({'password': _password});
      } else {
        print('User not found.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: ForgotPasswordAppBar()),
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
                    ),
                    Container(
                        width: double.infinity,
                        child: TextFormField(
                          onChanged: (value) => _email = value.trim(),
                          validator: (value) {
                            print(value);
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number or email address';
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
                    Container(
                        width: double.infinity,
                        child: TextFormField(
                          onChanged: (value) => _password = value.trim(),
                          obscureText: _obscureText,
                          validator: (value) {
                            print(value);
                            if (value == null || value.isEmpty) {
                              return 'Please enter the new password';
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
                        )),
                    SizedBox(height: 8),
                    Container(
                        width: double.infinity,
                        child: TextFormField(
                          obscureText: _obscureTextNew,
                          validator: (value) {
                            print(value);
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _password) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirm new password',
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
                                  _obscureTextNew = !_obscureTextNew;
                                });
                              },
                            ),
                            fillColor: Colors.grey[100],
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(height: 18),
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
                              child: Text('Confirm Password',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                if (validate.currentState!.validate()) {
                                  _resetPassword();
                                }
                              })),
                    ),
                  ],
                ),
              ),
            )));
  }
}
