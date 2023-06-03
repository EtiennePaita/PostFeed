import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostFeed'),
      ),
      body: Column(
        children: const [
          Text('data')
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