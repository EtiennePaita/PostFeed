import 'package:bloc/bloc.dart';
import 'package:post_feed/home_screen/post_bloc/posts_event.dart';
import 'package:post_feed/home_screen/post_bloc/posts_state.dart';
import 'package:post_feed/home_screen/repository/posts_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc({required this.repository}) : super(PostsState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostStatus.loading));

      try {
        final posts = await repository.getPosts();
        emit(state.copyWith(status: PostStatus.success, posts: posts));
      } catch (error) {
        emit(state.copyWith(status: PostStatus.error, error: error.toString()));
      }
    });
  }
}