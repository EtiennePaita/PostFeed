import 'package:flutter/material.dart';
import 'package:post_feed/home_screen/models/post.dart';
import 'package:post_feed/home_screen/post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostFeed'),
      ),
      body: Column(
        children: [
          PostItem(
            post: Post(
              id: 'SUUU',
              title: 'My first post !',
              description: '#firstTime #ecxiting #blog',
              content: 'This is my first post ever ! I will post regularly contents about me, about my dog and about my golden fish Charlysh. Stay awake ! :)',
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () => _onAddPostClick(),
      ),
    );
  }

  void _onAddPostClick() {
    debugPrint("_onAddPostClick");
    //navigate to add post form
  }
}
