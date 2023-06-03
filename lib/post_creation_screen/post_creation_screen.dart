import 'package:flutter/material.dart';

class PostCreationScreen extends StatelessWidget {
  static const String routeName = '/PostCreationScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const PostCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a post !'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: const [
            PostFormWidget(),
            Spacer(),
            ElevatedButton(
              onPressed: null,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostFormWidget extends StatelessWidget {
  const PostFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Title'),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your post title',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Description'),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: '#healthy #sport #lifestyle',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Post content'),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          minLines: null,
        ),
      ],
    );
  }
}
