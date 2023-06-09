
import '../../models/post.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostStatus status;
  final List<Post> posts;
  final String error;
  final StackTrace? stackTrace;

  PostsState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.error = '',
    this.stackTrace,
  });

  PostsState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? error,
    StackTrace? stackTrace,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace
    );
  }
}