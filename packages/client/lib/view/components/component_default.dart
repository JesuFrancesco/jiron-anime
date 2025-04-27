import 'package:flutter/material.dart';

enum DefaultUserIconSize { small, medium, large }

class DefaultUserIcon extends StatelessWidget {
  final DefaultUserIconSize size;
  const DefaultUserIcon({super.key, this.size = DefaultUserIconSize.medium});

  double getSize(DefaultUserIconSize s) {
    return switch (s) {
      DefaultUserIconSize.small => 30,
      DefaultUserIconSize.medium => 45,
      DefaultUserIconSize.large => 60,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: getSize(size),
        color: Colors.grey[600],
      ),
    );
  }
}
