import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
  Future<DocumentReference<Object?>> addPost(Post post);
}