import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/config/pallete.dart';
import 'package:facebook_clone/data/data.dart';
import 'package:facebook_clone/widget/profile-avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:facebook_clone/widget/post-container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeBuilder extends StatefulWidget {
  const HomeBuilder({super.key});

  @override
  State<HomeBuilder> createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {
  // Firebase Variables defined to fetch data from the database
  FirebaseApp firebaseApp = Firebase.app();

  late final firestoreRef = FirebaseFirestore.instanceFor(app: firebaseApp)
      .collection("users")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: firestoreRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            );
          }

          if (snapshot.hasError) {
            print(snapshot);
            return const Text('Something went wrong');
          }

          print(snapshot.data!.docs);
          print("Snapshot Data");

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                ProfileAvatar(
                                    imageUrl: snapshot.data!.docs[index]
                                        ["post_image"]),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['time_ago'],
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Icon(
                                            Icons.public,
                                            color: Colors.grey,
                                            size: 12,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text("Same Caption"),
                            snapshot.data!.docs[index]['post_image'] != ""
                                ? const SizedBox.shrink()
                                : const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      snapshot.data!.docs[index]['post_image'] != ""
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index]
                                      ['post_image']),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Palette.facebookBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    "22",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                Text(
                                  "22 likes",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "22 shares",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              MdiIcons.thumbUpOutline,
                                              color: Colors.grey[600],
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text("Like"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              MdiIcons.commentOutline,
                                              color: Colors.grey[600],
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text("Comment"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        height: 25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              MdiIcons.shareOutline,
                                              color: Colors.grey[600],
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text("Share"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
