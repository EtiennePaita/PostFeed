import 'package:post_feed/home_screen/data_sources/posts_data_source.dart';

import '../../models/post.dart';


class ApiPostsDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(10, (index) {
      return Post(
        id: 'P$index',
        title: 'MYL Blog #${index + 1}',
        description: '#firstTime #ecxiting #blog',
        content: 'This is my first post ever ! I will post regularly contents about me, about my dog and about my golden fish Charlysh. Stay awake ! :)',
      );
    });
  }
}