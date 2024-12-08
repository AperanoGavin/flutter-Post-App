import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post_model.dart';
import '../blocs/posts_bloc/posts_bloc.dart';
import '../blocs/posts_bloc/posts_event.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _errorMessage; 

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
        title: const Text('Add New Post'),
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

                final newPost = Post(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
                context.read<PostsBloc>().add(AddPost(newPost)); 
                Navigator.pop(context);
              },
              child: const Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}

