import 'package:facebook_clone/widget/profile-avatar.dart';
import 'package:flutter/material.dart';

// Data imports
import 'package:facebook_clone/data/data.dart';

class CreatePostContainer extends StatelessWidget {
  User currentUser = const User(name: "", imageUrl: "");
  final isRoom = 0;

  CreatePostContainer({Key? key, required this.currentUser, required isRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              // Loads the user's profile picture
              ProfileAvatar(imageUrl: currentUser.imageUrl),
              const SizedBox(
                width: 8,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: "What's on your mind?",
                    fillColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 0.5,
          ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam,
                    color: Colors.red,
                  ),
                  label: const Text("Live"),
                ),
                const VerticalDivider(
                  width: 8,
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.green,
                  ),
                  label: const Text("Photo"),
                ),
                const VerticalDivider(
                  width: 8,
                ),
                isRoom == 1
                    ? TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.video_call,
                          color: Colors.purpleAccent,
                        ),
                        label: const Text("Room"),
                      )
                    : TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flag_outlined,
                          color: Colors.purpleAccent,
                        ),
                        label: const Text("Life event"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
