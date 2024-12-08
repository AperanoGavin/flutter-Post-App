import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/posts_repository.dart'; 
import '../../models/post_model.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository; 

  PostsBloc(this.postsRepository) : super(const PostsState()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    add(FetchPosts());
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final posts = await postsRepository.getAllPosts(); 
      emit(state.copyWith(status: PostsStatus.loaded, posts: posts));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onAddPost(
    AddPost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      await postsRepository.createPost(event.newPost); // use postsRepository
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(status: PostsStatus.loaded, posts: posts));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onUpdatePost(
    UpdatePost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      await postsRepository.updatePost(event.updatedPost); 
      final posts = await postsRepository.getAllPosts();
      emit(state.copyWith(status: PostsStatus.loaded, posts: posts));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: error.toString(),
      ));
    }
  }
}
