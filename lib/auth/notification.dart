import 'package:flutter/material.dart';
import 'package:facebook_clone/data/data.dart';

// Data import
import 'package:facebook_clone/data/data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final List<User> firstSixUsers =
        onlineUsers.isNotEmpty ? onlineUsers.sublist(0, 6) : [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Text('Notification',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text('Earlier',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: firstSixUsers.map((user) {
                  final name = user.name;
                  final imageUrl = user.imageUrl;
                  final index = firstSixUsers.indexOf(user);
                  final text = index == 0 || index == 3 || index == 6
                      ? ' reacted to your post'
                      : ' commented on your post';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: text,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text('Just now'),
                    trailing: Icon(Icons.more_horiz),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
