part of 'posts_bloc.dart';

enum PostsStatus { initial, loading, loaded, error }

class PostsState {
  final List<Post> posts;
  final PostsStatus status;
  final String? error;

  const PostsState({
    this.posts = const <Post>[],
    this.status = PostsStatus.initial,
    this.error,
  });

  PostsState copyWith({
    List<Post>? posts,
    PostsStatus? status,
    String? error,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  String toString() {
    return 'PostsState(posts: $posts, status: $status, error: $error)';
  }
}
