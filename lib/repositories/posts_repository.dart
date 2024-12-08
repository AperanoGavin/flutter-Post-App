import '../models/post_model.dart';
import 'fake_posts_datasource.dart'; // Import fake data source

class PostsRepository {
  final FakePostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    try {
      return await postsDataSource.getAllPosts(); //get all posts
    } catch (e) {
      rethrow; 
    }
  }

  Future<Post> createPost(Post post) async {
    try {
      await postsDataSource.createPost(post); 
      return post; 
    } catch (e) {
      rethrow; 
    }
  }

  Future<Post> updatePost(Post post) async {
    try {
      await postsDataSource.updatePost(post); 
      return post; 
    } catch (e) {
      rethrow; 
    }
  }
}
