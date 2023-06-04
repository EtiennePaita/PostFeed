import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_event.dart';
import 'package:post_feed/home_screen/post_bloc/posts_state.dart';
import 'package:post_feed/models/post.dart';

class PostCreationScreen extends StatefulWidget {
  final VoidCallback? formValidationCallback;
  final Post? post;

  static const String routeName = '/PostCreationScreen';

  static void navigateTo(BuildContext context, Post? post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const PostCreationScreen({
    super.key,
    this.formValidationCallback,
    this.post
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
  void initState() {
    super.initState();
    if(widget.post != null) {
      titleController.text = widget.post?.title ?? '';
      contentController.text = widget.post?.content ?? '';
      descriptionController.text = widget.post?.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.post != null ? const Text('Edit') : const Text('Create a post !'),
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
                    titleController.clear();
                    descriptionController.clear();
                    contentController.clear();
                    if(widget.post != null) {
                      _showSnackBar(context, 'Votre post a été modifié !');
                    } else {
                      _showSnackBar(context, 'Votre post a été ajouté !');
                    }
                    //Navigator.of(context).pop();
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
                          onPressed: () => widget.post != null ? _onEditPostClick(context) : _onCreatePostClick(context),
                          child: widget.post != null ? const Text('Edit') : const Text('Create'),
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

  void _onEditPostClick(BuildContext context) {
    final newPost = Post(
      id: widget.post?.id ?? '',
      title: titleController.text,
      description: descriptionController.text,
      content: contentController.text,
    );
    BlocProvider.of<PostsBloc>(context).add(EditPost(newPost));
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
