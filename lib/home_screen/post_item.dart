import 'package:flutter/material.dart';
import '../../models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostItem({
    Key? key,
    required this.post,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
        onTap: onTap,
      ),
    );
  }
}
