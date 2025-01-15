import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/note_models.dart';

class CreateNote extends HookWidget {
  final Note? existingNote;
  final int? noteIndex;

  const CreateNote({
    super.key,
    this.existingNote,
    this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: existingNote?.title ?? '');
    final bodyController = useTextEditingController(text: existingNote?.body ?? '');

    // GetStorage instance
    final box = GetStorage();

    // Save note to GetStorage
    void saveNote() {
      if (titleController.text.isEmpty || bodyController.text.isEmpty) {
        Navigator.pop(context);
        return;
      }

      final note = Note(
        title: titleController.text,
        body: bodyController.text,
      );

      // Store note data as a map directly in GetStorage
      box.write('note_${note.title}', {
        'title': note.title,
        'body': note.body,
      });

      Navigator.pop(context, note);
    }

    // Load a specific note if exists
    void loadNote() {
      final savedNote = box.read('note_${existingNote?.title}');
      if (savedNote != null) {
        titleController.text = savedNote['title'];
        bodyController.text = savedNote['body'];
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            saveNote();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: TextField(
          controller: titleController,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: Colors.black54,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_book_rounded),
            tooltip: "Reading Mode",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_a_photo),
            tooltip: "Add Photo",
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'edit_cover':
                  break;
                case 'page_template':
                  break;
                case 'page_settings':
                  break;
                case 'full_screen':
                  break;
                case 'tags':
                  break;
                case 'save_as_file':
                  break;
                case 'star':
                  break;
                case 'share':
                  break;
                case 'delete':
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit_cover',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Cover'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'page_template',
                child: ListTile(
                  leading: Icon(Icons.assessment),
                  title: Text('Page Template'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'page_settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Page Settings'),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'full_screen',
                child: Text('Full Screen'),
              ),
              PopupMenuItem<String>(
                value: 'tags',
                child: Text('Tags'),
              ),
              PopupMenuItem<String>(
                value: 'save_as_file',
                child: Text('Save as File'),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: bodyController,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          maxLines: null,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.brush, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.check_box_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.format_align_left, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.text_fields, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.border_all, color: Colors.black),
              onPressed: () {},
            ),
            DropdownButton<int>(
              value: 20,
              items: List.generate(30, (index) => index + 1)
                  .map((size) => DropdownMenuItem<int>(
                        value: size,
                        child: Text('$size'),
                      ))
                  .toList(),
              onChanged: (int? newSize) {},
            ),
            IconButton(
              icon: Icon(Icons.undo, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.redo, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
