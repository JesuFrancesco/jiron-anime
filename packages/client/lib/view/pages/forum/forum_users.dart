class ForumUser {
  final String name;
  final String avatarUrl;

  ForumUser({required this.name, required this.avatarUrl});
}

final List<ForumUser> users = [
  ForumUser(name: 'user24', avatarUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzMonHZavwoawW_Rvz6AKrIHLOm1lYtn48Rw&s'),
  ForumUser(name: 'user25', avatarUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYcIQV8brWDNJkKz6N5ATQyM91W8oGWVD-Og&s'),
  ForumUser(name: 'Patrick', avatarUrl: 'https://cdn-icons-png.flaticon.com/512/518/518713.png'),
];