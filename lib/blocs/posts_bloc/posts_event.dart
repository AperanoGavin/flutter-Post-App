import '../../models/post_model.dart';

abstract class PostsEvent {}

class FetchPosts extends PostsEvent {}

class AddPost extends PostsEvent {
  final Post newPost;

  AddPost(this.newPost);
}

class UpdatePost extends PostsEvent {
  final Post updatedPost;

  UpdatePost(this.updatedPost);
}
