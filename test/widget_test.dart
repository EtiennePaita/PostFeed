// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post_feed/home_screen/home_screen.dart';
import 'package:post_feed/home_screen/post_bloc/posts_bloc.dart';
import 'package:post_feed/home_screen/repository/posts_repository.dart';

import 'tests_data_source.dart';

void main() {

  testWidgets('Empty list', (WidgetTester tester) async {
    await tester.pumpWidget(
      RepositoryProvider(
        create: (context) => PostsRepository(
          postsDataSource: EmptyPostsDataSource(),
        ),
        child: BlocProvider<PostsBloc>(
          create: (context) => PostsBloc(
            repository : RepositoryProvider.of<PostsRepository>(context),
          ),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text("Aucun post"), findsOneWidget);
  });
}
