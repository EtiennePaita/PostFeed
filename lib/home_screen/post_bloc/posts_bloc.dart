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
        await for (var posts in repository.getPosts()) {
          emit(state.copyWith(posts: posts, status: PostStatus.success));
        }
      } catch (error, stackTrace) {
        emit(state.copyWith(
          status: PostStatus.error,
          error: error.toString(),
          stackTrace: stackTrace,
        ));
      }
    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostStatus.loading));
      final newPost = event.newPost;

      try {
        final post = await repository.addPost(newPost);
        print(post);
        emit(state.copyWith(status: PostStatus.success));
      } catch (error, stackTrace) {
        emit(state.copyWith(
          status: PostStatus.error,
          error: error.toString(),
          stackTrace: stackTrace,
        ));
      }
    });

    on<EditPost>((event, emit) async {
      emit(state.copyWith(status: PostStatus.loading));
      try {
        await repository.editPost(event.post);
        emit(state.copyWith(status: PostStatus.success));
      } catch (error, stackTrace) {
        emit(state.copyWith(
          status: PostStatus.error,
          error: error.toString(),
          stackTrace: stackTrace,
        ));
      }
    });

  }
}
