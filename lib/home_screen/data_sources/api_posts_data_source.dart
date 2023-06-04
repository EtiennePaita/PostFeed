import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:post_feed/home_screen/data_sources/posts_data_source.dart';

import '../../models/post.dart';

class ApiPostsDataSource extends PostsDataSource {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Stream<List<Post>> getPosts() {
    return postCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Post(
              id: doc.id,
              title: doc.get('title'),
              description: doc.get('description'),
              content: doc.get('content'),
            ))
        .toList());
  }

  @override
  Future<DocumentReference<Object?>> addPost(Post post) async {
    return await postCollection.add({
      "title": post.title,
      "description": post.description,
      "content": post.content
    });
  }
}
