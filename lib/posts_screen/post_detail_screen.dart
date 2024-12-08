import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post_model.dart';
import '../blocs/posts_bloc/posts_bloc.dart';
import '../blocs/posts_bloc/posts_event.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
    _descriptionController.text = widget.post.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
                  setState(() {
                    _errorMessage = 'Title and Description cannot be empty';
                  });
                  return;
                }

                final updatedPost = widget.post.copyWith(
                  title: _titleController.text,
                  description: _descriptionController.text,
                );

                context.read<PostsBloc>().add(UpdatePost(updatedPost));
                Navigator.pop(context);
              },
              child: const Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
