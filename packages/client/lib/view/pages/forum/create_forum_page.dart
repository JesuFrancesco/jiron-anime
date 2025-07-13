import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'forum_page.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';

class CreateForumPage extends StatefulWidget {
  const CreateForumPage({super.key});

  @override
  State<CreateForumPage> createState() => _CreateForumPageState();
}

class _CreateForumPageState extends State<CreateForumPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _createForum() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Error", "Completa todos los campos");
      return;
    }

    final newPost = ForumPost(
      username: AuthController.fullName ?? 'Anónimo',
      avatarUrl:
          AuthController.profileImageUrl ?? 'https://via.placeholder.com/150',
      question: title,
      userText: content,
      likes: 0,
      shares: 0,
      imageUrl:
          _image != null
              ? _image!
                  .path // Temporal: usaremos path local
              : 'https://via.placeholder.com/150', // Imagen por defecto
      initialComments: [],
    );

    forumPosts.insert(0, newPost); // Añadir al inicio
    Get.back(); // Volver a la pantalla anterior
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Foro'),
        backgroundColor: isDarkMode ? Color(0xFFB22525) : Color(0xFFFFD6A5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título de la discusión',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text("Subir Imagen"),
                  ),
                  const SizedBox(width: 12),
                  if (_image != null)
                    Expanded(
                      child: Image.file(
                        _image!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _createForum,
                icon: const Icon(Icons.send),
                label: const Text('Publicar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? Color(0xFFB22525) : Color(0xFFFFD6A5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
