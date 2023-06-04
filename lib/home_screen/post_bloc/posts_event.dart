
import 'package:flutter/cupertino.dart';

import '../../models/post.dart';

@immutable
abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {}

class AddPost extends PostsEvent {
  final Post newPost;

  AddPost(this.newPost);
}

class EditPost extends PostsEvent {
  final Post post;

  EditPost(this.post);
}
