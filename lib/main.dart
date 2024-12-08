import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_screen/posts_list_screen.dart';
import 'posts_screen/add_post_screen.dart';
import 'posts_screen/post_detail_screen.dart';
import 'blocs/posts_bloc/posts_bloc.dart';
import 'repositories/posts_repository.dart';
import 'repositories/fake_posts_datasource.dart';
import 'models/post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Fournir PostsRepository avec FakePostsDataSource
        RepositoryProvider(
          create: (context) => PostsRepository(
            postsDataSource: FakePostsDataSource(), // Utilisation de la source fictive
          ),
        ),
        // Fournir PostsBloc avec PostsRepository
        BlocProvider(
          create: (context) => PostsBloc(
            context.read<PostsRepository>(), // Passer le PostsRepository
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Posts App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) =>  PostsListScreen(),
          '/add_post': (context) =>  AddPostScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          Widget screen = Container(color: Colors.red); // Valeur par défaut
          final argument = settings.arguments;
          switch (settings.name) {
            case '/post_detail':
              if (argument is Post) {
                screen = PostDetailScreen(post: argument);
              }
              break;
          }
          return MaterialPageRoute(builder: (context) => screen);
        },
      ),
    );
  }
}
