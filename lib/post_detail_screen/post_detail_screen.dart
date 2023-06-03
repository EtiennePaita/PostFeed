import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_screen/models/post.dart';

class PostDetailScreen extends StatelessWidget {
  static const String routeName = '/PostDetailScreen';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  final Post post;

  const PostDetailScreen({
    super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Column(
        children: [
          Text(post.description),
          Text(post.content),
        ],
      ),
    );
  }

}