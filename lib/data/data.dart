class User {
  final String name;
  final String imageUrl;
  final String coverImageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIN_BCkQXL1ieIwfebfdQfxyM0BEz7grMWc5KBRA04dR6AMOC1XdXjwZS0jib86j5faUE&usqp=CAU";

  const User({required this.name, required this.imageUrl, coverImageUrl});
}

class Friend {
  final String name;
  final String imageUrl;

  const Friend({required this.name, required this.imageUrl, coverImageUrl});
}

class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final int likes;
  final int comments;
  final int shares;

  const Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

// final User currentUser = FirebaseAuth.instance.currentUser;
const User currentUser = User(
  name: "Kaushal Poojary",
  imageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaHqzu1CfvHyWJ_L2MuTYvOoZDqa4hI1PLrQ&usqp=CAU",
);

const List<User> onlineUsers = [
  User(
      name: "Salman Khan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSusf6GvKLXC6u_fCczoIVTX9NMpdzHG_qong&usqp=CAU"),
  User(
      name: "Shah Rukh Khan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWv4h_INtKEg-Bg-VJKggN4zh7ZJ7eE7QPw&usqp=CAU"),
  User(
      name: "Hrithik Roshan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0aMSu5EgHTSqOFoeBy-FEbmwJtFORhnP1ZA&usqp=CAU"),
  User(
      name: "Ajay Devgan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC9Gc-PXzCsGEi2JVKNJhQvtedwIOe2i_6nQ&usqp=CAU"),
  User(
      name: "Amitabh Bachchan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGlNvNrjFdmWYut5MmkxXEezce2EqPqQzvaA&usqp=CAU"),
  User(
      name: "MS Dhoni",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyv9oKrr__xd-rXbiXCJllh6Pbz0kHyRS9bg&usqp=CAU"),
  User(
      name: "Ricky Ponting",
      imageUrl:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Alyssa Smith",
      imageUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Kyle Anderson",
      imageUrl:
          "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Samantha Jones",
      imageUrl:
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Rajiv Singh",
      imageUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "John Doe",
      imageUrl:
          "https://images.unsplash.com/photo-1485206412256-701ccc5b93ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJhbmRvbSUyMHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Jennifer Aniston",
      imageUrl:
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Elinor Pender",
      imageUrl:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Emma Traverso",
      imageUrl:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Liam O'Leary",
      imageUrl:
          "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Olivia O'Leary",
      imageUrl:
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Pradeep Kumar",
      imageUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Gary Coleman",
      imageUrl:
          "https://images.unsplash.com/photo-1485206412256-701ccc5b93ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHJhbmRvbSUyMHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
  User(
      name: "Samantha Smith",
      imageUrl:
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
];

final List<Story> stories = [
  Story(
    user: onlineUsers[2],
    imageUrl: 'https://static.toiimg.com/photo/96418218/96418218.jpg?v=3',
  ),
  Story(
    user: onlineUsers[6],
    imageUrl:
        'https://media.gettyimages.com/id/73431330/photo/ricky-ponting-poses-with-the-1999-and-2003-world-cup-trophies-during-the-australian-cricket.jpg?s=612x612&w=gi&k=20&c=8QAzcllR62MbBuMxM-T6vWoslwlW21t-fZvpgKBHG78=',
    isViewed: true,
  ),
  Story(
    user: onlineUsers[3],
    imageUrl:
        'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=624&q=80',
  ),
  Story(
    user: onlineUsers[9],
    imageUrl:
        'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  Story(
    user: onlineUsers[7],
    imageUrl:
        'https://images.unsplash.com/photo-1475688621402-4257c812d6db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
  ),
  Story(
    user: onlineUsers[2],
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
  ),
  Story(
    user: onlineUsers[6],
    imageUrl:
        'https://images.unsplash.com/photo-1499363536502-87642509e31b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    isViewed: true,
  ),
  Story(
    user: onlineUsers[3],
    imageUrl:
        'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=624&q=80',
  ),
  Story(
    user: onlineUsers[9],
    imageUrl:
        'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  Story(
    user: onlineUsers[7],
    imageUrl:
        'https://images.unsplash.com/photo-1475688621402-4257c812d6db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80',
  ),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Loved this six',
    timeAgo: '58m',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0GEfxDQdNqrS1AFLBA_-Rw_U2vFuRFKSdTw&usqp=CAU',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    user: onlineUsers[5],
    caption:
        'Can\'t believe my team got banned for fixing matches. I am so sad. 😭',
    timeAgo: '3hr',
    imageUrl: "",
    likes: 683,
    comments: 79,
    shares: 18,
  ),
  Post(
    user: onlineUsers[4],
    caption: 'This is a very good boi.',
    timeAgo: '8hr',
    imageUrl:
        'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 894,
    comments: 201,
    shares: 27,
  ),
  Post(
    user: onlineUsers[3],
    caption: 'Adventure 🏔',
    timeAgo: '15hr',
    imageUrl:
        'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 722,
    comments: 183,
    shares: 42,
  ),
  Post(
    user: onlineUsers[0],
    caption:
        'A warm welcome to each one of you. Lets rock and roll with our new app. I am Salman Khan, your host for the day. Lets get started. And yes, dont forget to like and share this post. Thank you.',
    timeAgo: '1d',
    imageUrl: "",
    likes: 482,
    comments: 37,
    shares: 9,
  ),
  Post(
    user: onlineUsers[9],
    caption: 'A classic.',
    timeAgo: '1d',
    imageUrl:
        'https://images.unsplash.com/reserve/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 1523,
    shares: 129,
    comments: 301,
  )
];

const List<Friend> friends = [
  Friend(
      name: "Salman Khan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSusf6GvKLXC6u_fCczoIVTX9NMpdzHG_qong&usqp=CAU"),
  Friend(
      name: "Shah Rukh Khan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrWv4h_INtKEg-Bg-VJKggN4zh7ZJ7eE7QPw&usqp=CAU"),
  Friend(
      name: "Hrithik Roshan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0aMSu5EgHTSqOFoeBy-FEbmwJtFORhnP1ZA&usqp=CAU"),
  Friend(
      name: "Ajay Devgan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC9Gc-PXzCsGEi2JVKNJhQvtedwIOe2i_6nQ&usqp=CAU"),
  Friend(
      name: "Amitabh Bachchan",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGlNvNrjFdmWYut5MmkxXEezce2EqPqQzvaA&usqp=CAU"),
  Friend(
      name: "MS Dhoni",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyv9oKrr__xd-rXbiXCJllh6Pbz0kHyRS9bg&usqp=CAU"),
];
