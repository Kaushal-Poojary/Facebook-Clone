import 'package:flutter/material.dart';

// Creates a custom button with a circle background
class CircleButton1 extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const CircleButton1({
    Key key = const Key(''),
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      // Apply margin to the container
      margin: const EdgeInsets.all(6),
      // Adding a grey circle background to the icon
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
        onPressed: onPressed as void Function()?,
      ),
    );
  }
}

class CircleButton2 extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const CircleButton2({
    Key key = const Key(''),
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      // Apply margin to the container
      margin: const EdgeInsets.all(6),
      // Adding a grey circle background to the icon
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
        onPressed: onPressed as void Function()?,
      ),
    );
  }
}
