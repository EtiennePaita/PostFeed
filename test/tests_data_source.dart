import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_feed/home_screen/data_sources/posts_data_source.dart';
import 'package:post_feed/models/post.dart';

class EmptyPostsDataSource extends PostsDataSource {
  final StreamController<List<Post>> streamControllerPost = StreamController<List<Post>>();

  @override
  Future<DocumentReference<Object?>> addPost(Post post) {
    throw UnimplementedError();
  }

  @override
  Future<void> editPost(Post post) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Post>> getPosts() {
    streamControllerPost.add(<Post>[]);
    return streamControllerPost.stream;
  }
}