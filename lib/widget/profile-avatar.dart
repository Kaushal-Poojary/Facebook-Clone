import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/pallete.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  String imageUrl = "";
  // To check if the user is active or not
  bool isActive;
  // To check if the story has been viewed or not
  bool hasBorder;

  ProfileAvatar({
    Key key = const Key(''),
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Palette.facebookBlue,
          child: CircleAvatar(
            radius: hasBorder ? 17 : 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        // Shows the green dot if the user is active
        isActive
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: Palette.online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
