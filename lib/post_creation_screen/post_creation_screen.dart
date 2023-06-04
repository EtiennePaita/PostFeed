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

class PostForm extends StatefulWidget {
  final VoidCallback? formValidationCallback;
  final String? title;
  final String? description;
  final String? content;

  const PostForm({
    super.key,
    required this.formValidationCallback,
    this.title,
    this.description,
    this.content
  });

  @override
  State<PostForm> createState() => PostFormState();
}


class PostFormState extends State<PostForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Title'),
        ),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your post title',
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Description'),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '#healthy #sport #lifestyle',
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text('Post content'),
        ),
        TextField(
          controller: contentController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          minLines: null,
        ),
      ],
    );
  }
}
