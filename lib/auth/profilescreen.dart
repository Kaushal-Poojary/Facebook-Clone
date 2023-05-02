// Core imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/auth/forgotpassword.dart';
import 'package:facebook_clone/auth/login.dart';
import 'package:flutter/material.dart';

// Data import
import 'package:facebook_clone/config/pallete.dart';
import 'package:facebook_clone/data/data.dart';

// Widgets import
import 'package:facebook_clone/widget/create-post-container.dart';
import 'package:facebook_clone/widget/post-container.dart';
import 'package:facebook_clone/widget/rooms.dart';
import 'package:facebook_clone/widget/stories.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String email;
  const ProfileScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<String> getNameFromEmail(String email) async {
  String fname = "", lname = "", full_name = "";
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    querySnapshot.docs.forEach((doc) {
      fname = doc.get('first_name');
      lname = doc.get('last_name');
      full_name = fname + " " + lname;
    });
  } catch (e) {
    print(e);
  }
  return full_name;
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isZoomed = false;

  String name = "";

  @override
  void initState() {
    super.initState();
    getNameFromEmail(widget.email).then((value) {
      setState(() {
        name = value;
        print(name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? firstUser = onlineUsers.isNotEmpty ? onlineUsers.first : null;
    final String imageUrl = firstUser != null ? firstUser.imageUrl : '';

    final User? secondUSer = onlineUsers.isNotEmpty ? onlineUsers[1] : null;
    final String imageUrl2 = secondUSer != null ? secondUSer.imageUrl : '';

    void showPopupMenu() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bcx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Gallery'),
                  onTap: () => {},
                ),
              ],
            );
          });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              // To prevent the image from clipping(getting cut off)
              clipBehavior: Clip.none,
              children: [
                // Cover Image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isZoomed = !_isZoomed;
                    });
                    if (_isZoomed) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Scaffold(
                              backgroundColor: Colors.black,
                              body: Center(
                                child: Hero(
                                  tag: 'coverImage',
                                  child:
                                      Image.network(currentUser.coverImageUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(currentUser.coverImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Profile Image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isZoomed = !_isZoomed;
                    });
                    if (_isZoomed) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Scaffold(
                              backgroundColor: Colors.black,
                              body: Center(
                                child: Hero(
                                  tag: 'profileImage',
                                  child: Image.network(currentUser.imageUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Transform.translate(
                    offset: Offset(
                        10.0, MediaQuery.of(context).size.height - 600.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          currentUser.imageUrl,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 260,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          left: 20,
                          child: Column(
                            children: [
                              // Name and username
                              Container(
                                width: 360,
                                child: Text(name,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(height: 15),
                              // Add story and edit profile button
                              Container(
                                width: 370,
                                child: Row(
                                  children: [
                                    // Add story button
                                    Container(
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Palette.facebookBlue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 5),
                                              Text('Log Out',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()),
                                            );
                                          },
                                        )),
                                    SizedBox(width: 5),
                                    // Edit profile button
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                color: Colors.black, size: 20),
                                            SizedBox(width: 5),
                                            Text(
                                              'Edit Profile',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 40,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.more_horiz,
                                                color: Colors.black, size: 20),
                                            onPressed: () {
                                              showPopupMenu();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              // Bio
                              Container(
                                  width: 360,
                                  child: Row(
                                    children: [
                                      Icon(Icons.school,
                                          color: Colors.grey, size: 20),
                                      SizedBox(width: 5),
                                      Text.rich(TextSpan(
                                        text: "Went to ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'St. Pius X High School',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 360,
                                  child: Row(
                                    children: [
                                      Icon(Icons.home,
                                          color: Colors.grey, size: 20),
                                      SizedBox(width: 5),
                                      Text.rich(TextSpan(
                                        text: "Lives in ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Mumbai, Maharashtra',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              // Location
                              Container(
                                  width: 360,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.grey, size: 20),
                                      SizedBox(width: 5),
                                      Text.rich(TextSpan(
                                        text: "From ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Udupi, Karnataka',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ],
                                      ))
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              // Joined Date
                              Container(
                                  width: 360,
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time_filled_outlined,
                                          color: Colors.grey, size: 20),
                                      SizedBox(width: 5),
                                      Text('Joined November 2016',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 360,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 216, 231, 244),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton(
                                  child: Text(
                                    'Edit public details',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: Palette.facebookBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            // Photos and Videos
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Card(child: Image.network(imageUrl))),
                          Expanded(child: Card(child: Image.network(imageUrl))),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Card(child: Image.network(imageUrl))),
                          Expanded(child: Card(child: Image.network(imageUrl))),
                          Expanded(child: Card(child: Image.network(imageUrl))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 360,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 216, 231, 244),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          child: Text(
                            'See all photos',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                color: Palette.facebookBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Column(
                children:
                    posts.map((post) => PostContainer(post: post)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
