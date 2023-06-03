import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_feed/home_screen/data_sources/api_posts_data_source.dart';
import 'package:post_feed/home_screen/repository/posts_repository.dart';
import 'package:post_feed/post_creation_screen/post_creation_screen.dart';
import 'package:post_feed/post_detail_screen/post_detail_screen.dart';

import 'home_screen/home_screen.dart';
import 'home_screen/models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
          postsDataSource: ApiPostsDataSource()
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox.shrink();

          switch (settings.name) {
            case PostDetailScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is Post) {
                content = PostDetailScreen(post: arguments);
              }
              break;

            case PostCreationScreen.routeName:
              content = const PostCreationScreen();
              break;
          }

          return MaterialPageRoute(
            builder: (context) {
              return content;
            },
          );
        },
      ),
    );
  }
}
