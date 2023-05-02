import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Friend {
  final String name;
  final String profileImageUrl;

  Friend({required this.name, required this.profileImageUrl});
}

class FriendCard extends StatelessWidget {
  final Friend friend;

  FriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(friend.profileImageUrl),
        ),
      ),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            friend.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class FriendsSection extends StatelessWidget {
  final List<Friend> friends;

  FriendsSection({required this.friends});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: friends.map((friend) => FriendCard(friend: friend)).toList(),
      ),
    );
  }
}




