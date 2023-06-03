import 'package:post_feed/home_screen/models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
}