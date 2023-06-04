
import 'package:post_feed/home_screen/data_sources/posts_data_source.dart';
import '../../models/post.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({
    required this.postsDataSource,
  });

  Future<List<Post>> getPosts() async {
    try {
      return await postsDataSource.getPosts();
    } catch (e) {
      rethrow;
    }
  }
}