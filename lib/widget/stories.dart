import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/pallete.dart';
import 'package:facebook_clone/widget/profile-avatar.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';

class Stories extends StatelessWidget {
  User currentUser = User(name: "", imageUrl: "");
  List<Story> stories = [Story(user: onlineUsers[0], imageUrl: "")];

  Stories({Key? key, required this.currentUser, required this.stories})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + stories.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: _StoryCard(
                  isAddStory: true,
                  currentUser: currentUser,
                ),
              );
            }
            final Story story = stories[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: _StoryCard(story: story),
            );
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  bool isAddStory;
  User currentUser;
  Story story;

  _StoryCard(
      {Key? key,
      this.isAddStory = false,
      this.currentUser = const User(name: "", imageUrl: ""),
      this.story =
          const Story(user: User(name: "", imageUrl: ""), imageUrl: "")})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: double.infinity,
              width: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: isAddStory
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    // fit: BoxFit.contain,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      iconSize: 30,
                      color: Palette.facebookBlue,
                      // alignment: Alignment.center,
                    ),
                  ),
                )
              : ProfileAvatar(
                  imageUrl: story.user.imageUrl,
                  hasBorder: !story.isViewed,
                ),
        ),
        // Positions a widget relative to the bottom, left, and right of another widget.
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Text(
            isAddStory ? "Create Story" : story.user.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            // Max number of lines to show
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
