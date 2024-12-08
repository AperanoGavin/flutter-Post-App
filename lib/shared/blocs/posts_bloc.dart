import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp_flutter_5al2/repositories/fake_posts_datasource.dart';

import '../../models/post_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final FakePostsDataSource dataSource;

  PostsBloc(this.dataSource) : super(const PostsState()) {
    on<FetchPosts>(_onFetchPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  Future<void> _onFetchPosts(
    FetchPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final posts = await dataSource.getAllPosts();
      emit(state.copyWith(status: PostsStatus.loaded, posts: posts));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onCreatePost(
    CreatePost event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      await dataSource.createPost(event.post);
      final posts = await dataSource.getAllPosts();
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
      await dataSource.updatePost(event.updatedPost);
      final posts = await dataSource.getAllPosts();
      emit(state.copyWith(status: PostsStatus.loaded, posts: posts));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: error.toString(),
      ));
    }
  }
}
