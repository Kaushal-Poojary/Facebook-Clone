// Core imports
import 'package:flutter/material.dart';

// Data import
import 'package:facebook_clone/config/pallete.dart';
import 'package:facebook_clone/data/data.dart';

// Widgets import
import 'package:facebook_clone/widget/create-post-container.dart';
import 'package:facebook_clone/widget/post-container.dart';
import 'package:facebook_clone/widget/rooms.dart';
import 'package:facebook_clone/widget/stories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Home Screen",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            // Allows you to place a non-sliver widget, such as a Container, inside of a CustomScrollView
            SliverToBoxAdapter(
              child: CreatePostContainer(
                currentUser: currentUser,
                isRoom: 1,
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                )),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                sliver: SliverToBoxAdapter(
                  child: Stories(currentUser: currentUser, stories: stories),
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                while (index < posts.length) {
                  final Post post = posts[index];
                  index++;
                  return PostContainer(post: post);
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
