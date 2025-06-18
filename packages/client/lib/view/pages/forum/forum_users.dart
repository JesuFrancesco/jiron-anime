class ForumUser {
  final String name;
  final String avatarUrl;

  ForumUser({required this.name, required this.avatarUrl});
}

final List<ForumUser> users = [
  ForumUser(name: 'user24', avatarUrl: 'https://cdn.pfps.gg/pfps/3260-eren-yeager.png'),
  ForumUser(name: 'user25', avatarUrl: 'https://i.redd.it/kggiebjzutu41.jpg'),
  ForumUser(name: 'Patrick', avatarUrl: 'https://cdn-icons-png.flaticon.com/512/518/518713.png'),
];