import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_app/note_models.dart';

class ReplaceNote extends StatelessWidget {
  final Note note;
  final int index;
  final Function(Note updatedNote, int index) onNoteUpdated;

  const ReplaceNote({
    super.key,
    required this.note,
    required this.index,
    required this.onNoteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            minHeight: 160.0,
            minWidth: 100,
          ),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UpdateNote(
                note: note,
                index: index,
                onNoteUpdated: onNoteUpdated,
              ),
            )),
            child: Card(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    textAlign: TextAlign.start,
                    note.body,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 5,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            note.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class UpdateNote extends HookWidget {
  final Note note;
  final int index;
  final Function(Note updatedNote, int index) onNoteUpdated;

  const UpdateNote({
    super.key,
    required this.note,
    required this.index,
    required this.onNoteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final updatedTitleController = useTextEditingController(text: note.title);
    final updatedBodyController = useTextEditingController(text: note.body);

    void updateNote() {
      if (updatedTitleController.text.isEmpty ||
          updatedBodyController.text.isEmpty) {
        return;
      }
      final updatedNote = Note(
        title: updatedTitleController.text,
        body: updatedBodyController.text,
      );
      onNoteUpdated(updatedNote, index);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.picture_as_pdf)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'edit_cover':
                  break;
                case 'page_sorter':
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
                value: 'page_sorter',
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('Page Sorter'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'page_template',
                child: ListTile(
                  leading: Icon(Icons.assessment_outlined),
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
          controller: updatedBodyController,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
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
              onPressed: () {
               
              },
            ),
            IconButton(
              icon: Icon(Icons.check_box_outlined, color: Colors.black),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.format_align_left, color: Colors.black),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.text_fields, color: Colors.black),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.border_all, color: Colors.black),
              onPressed: () {
                
              },
            ),
            DropdownButton<int>(
              value: 20,
              items: List.generate(30, (index) => index + 1)
                  .map((size) => DropdownMenuItem<int>(
                        value: size,
                        child: Text('$size'),
                      ))
                  .toList(),
              onChanged: (int? newSize) {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.undo, color: Colors.black),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon: Icon(Icons.redo, color: Colors.black),
              onPressed: () {
                // Handle redo action
              },
            ),
          ],
        ),
      ),
    );
  }
}
