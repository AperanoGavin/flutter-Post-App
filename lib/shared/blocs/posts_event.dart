part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class FetchPosts extends PostsEvent {}

class CreatePost extends PostsEvent {
  final Post post;

  CreatePost(this.post);
}

class UpdatePost extends PostsEvent {
  final Post updatedPost;

  UpdatePost(this.updatedPost);
}
