import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostListItem({Key? key, required this.post, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
