import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_event.dart';
import 'package:post_feed/home_screen/post_bloc/posts_state.dart';
import 'package:post_feed/models/post.dart';

class PostCreationScreen extends StatefulWidget {
  final VoidCallback? formValidationCallback;
  final String? title;
  final String? description;
  final String? content;

  static const String routeName = '/PostCreationScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const PostCreationScreen({
    super.key,
    this.formValidationCallback,
    this.title,
    this.description,
    this.content,
  });

  @override
  State<PostCreationScreen> createState() => PostFormState();
}

class PostFormState extends State<PostCreationScreen> {
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
            BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                switch (state.status) {
                  case PostStatus.error:
                    FirebaseCrashlytics.instance
                        .recordError(state.error, state.stackTrace);
                    _showSnackBar(
                        context, 'Une erreur est surevenue. Réessayez plus tard.');
                    break;

                  case PostStatus.success:
                    _showSnackBar(context, 'Votre post a été ajouté !');
                    break;

                  case PostStatus.initial:
                    break;
                  case PostStatus.loading:
                    break;
                }
              },
              builder: (context, state) {

                switch (state.status) {
                  case PostStatus.loading:
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  default:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: () => _onCreatePostClick(context),
                          child: const Text('Post'),
                        ),
                      ),
                    );

                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onCreatePostClick(BuildContext context) {
    final newPost = Post(
      id: 'N000',
      title: titleController.text,
      description: descriptionController.text,
      content: contentController.text,
    );
    BlocProvider.of<PostsBloc>(context).add(AddPost(newPost));
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
