import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post.dart';
import 'package:post_feed/home_screen/post_bloc/posts_bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_state.dart';
import 'package:post_feed/home_screen/post_item.dart';
import 'package:post_feed/post_creation_screen/post_creation_screen.dart';
import 'package:post_feed/post_detail_screen/post_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostFeed'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.initial:
              return const SizedBox();

            case PostStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case PostStatus.error:
              FirebaseCrashlytics.instance
                  .recordError(state.error, state.stackTrace);
              return Center(
                child: Text(state.error),
              );

            case PostStatus.success:
              final posts = state.posts;

              if (posts.isEmpty) {
                return const Center(
                  child: Text('Aucun post'),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostItem(
                      post: post,
                      onTap: () => _onPostTap(context, post),
                    );
                  },
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () => _onAddPostClick(context),
      ),
    );
  }

  void _onAddPostClick(BuildContext context) {
    PostCreationScreen.navigateTo(context);
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
    //navigate to add post form
  }
}
