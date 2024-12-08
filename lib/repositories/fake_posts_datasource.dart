import '../models/post_model.dart';

class FakePostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Cristiano', description: 'Best player in the world'),
    Post(id: '2', title: 'Messi', description: 'Second best player in the world'),
    Post(id: '3', title: 'Mbappe', description: 'Third best player in the world in his world'),
  ];

  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1)); // fake delay
    return _fakePosts;
  }

  Future<Post> createPost(Post post) async {
    await Future.delayed(const Duration(seconds: 1)); 
    _fakePosts.add(post);
    return post; 
  }

  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1)); 
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost; 
    } else {
      throw Exception('Post not found'); 
    }
  }
}
