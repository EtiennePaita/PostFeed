import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_feed/home_screen/data_sources/api_posts_data_source.dart';
import 'package:post_feed/home_screen/repository/posts_repository.dart';
import 'package:post_feed/post_creation_screen/post_creation_screen.dart';
import 'package:post_feed/post_detail_screen/post_detail_screen.dart';

import 'analytics/analytics_provider.dart';
import 'analytics/firebase_analytics_handler.dart';
import 'firebase_options.dart';
import 'home_screen/home_screen.dart';
import '../../models/post.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import 'home_screen/post_bloc/posts_bloc.dart';
import 'home_screen/post_bloc/posts_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrongScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnalyticsProvider(
      handlers: [
        FirebaseAnalyticsHandler(),
      ],
      child: RepositoryProvider(
        create: (context) =>
            PostsRepository(
                postsDataSource: ApiPostsDataSource()
            ),
        child: BlocProvider(
          create: (context) => PostsBloc(
            repository: RepositoryProvider.of<PostsRepository>(context),
          )..add(GetAllPosts()),
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
        ),
      ),
    );
  }
}

class SomethingWentWrongScreen extends StatelessWidget {
  const SomethingWentWrongScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostFeed'),
      ),
      body: const Center(
        child: Text('Something went wrong...\nPlease try again later'),
      ),
    );
  }
}
