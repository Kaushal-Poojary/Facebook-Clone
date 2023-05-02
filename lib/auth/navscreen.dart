import 'package:facebook_clone/auth/homescreen.dart';
import 'package:facebook_clone/auth/notification.dart';
import 'package:facebook_clone/auth/profilescreen.dart';
import 'package:facebook_clone/config/pallete.dart';
import 'package:facebook_clone/widget/circle-button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  final String email;
  const NavScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _children = [
    const HomeScreen(),
    const ProfileScreen(email: ''),
    const NotificationScreen(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    MdiIcons.accountCircleOutline,
    Icons.notifications,
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _children[1] = ProfileScreen(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                // Align the title to the left
                backgroundColor: Colors.white,
                centerTitle: false,
                title: Text(
                  "facebook",
                  style: GoogleFonts.roboto(
                    color: Palette.facebookBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: -1.2,
                  ),
                ),
                floating: false,
                actions: [
                  CircleButton1(
                      icon: Icons.search, iconSize: 30, onPressed: () {}),
                  Container(
                    // Apply margin to the container
                    margin: const EdgeInsets.all(6),
                    // Adding a grey circle background to the icon
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(MdiIcons.facebookMessenger),
                      iconSize: 30,
                      color: Colors.black,
                      onPressed: () {},
                    ),
                  ),
                ],
                bottom: TabBar(
                  tabs: _icons
                      .asMap()
                      .map(
                        (i, e) => MapEntry(
                          i,
                          Tab(
                            icon: Container(
                              child: Icon(e,
                                  color: selectedIndex == i
                                      ? Colors.blue
                                      : Colors.black),
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
              SliverFillRemaining(
                child: IndexedStack(
                  index: selectedIndex,
                  children: _children,
                ),
              ),
            ],
          ),
        ));
  }
}
