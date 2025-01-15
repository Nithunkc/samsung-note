import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/drawer.dart';
import 'package:note_app/create_note.dart';
import 'package:note_app/note_models.dart';
import 'package:note_app/recycle_notes.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final notes = useState<List<Note>>([]);
    final bin = useState<List<Trash>>([]);
    final selectedNotes = useState<Set<int>>({});
    final isSelectionMode = useState(false);
    final opacityLarge = useState(1.0);
    final opacitySmall = useState(0.0);
    final scrollController = useScrollController();
    final gridSize = useState('size');

    void _loadNotes() {
      final List storedNotes = storage.read<List>('notes') ?? [];
      notes.value =
          storedNotes.map((noteData) => Note.fromJson(noteData)).toList();
    }

    
    useEffect(() {
      _loadNotes();
      return null;
    }, []);


    
    void _saveNotes() {
      final List<Map<String, dynamic>> notesToSave =
          notes.value.map((note) => note.toJson()).toList();
      storage.write('notes', notesToSave);
    }

    void addNoteToHomePage(Note note) {
      notes.value = [...notes.value, note];
      _saveNotes();
    }



void restoreNoteToHomePage(Note note) {
      notes.value = [...notes.value, note];
    }


    Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    void toggleSelection(int index) {
      final newSelection = Set<int>.from(selectedNotes.value);
      if (newSelection.contains(index)) {
        newSelection.remove(index);
      } else {
        newSelection.add(index);
      }
      selectedNotes.value = newSelection;

      if (newSelection.isEmpty) {
        isSelectionMode.value = false;
      }
    }

    void selectAll() {
      if (selectedNotes.value.length == notes.value.length) {
        selectedNotes.value = {};
        isSelectionMode.value = false;
      } else {
        selectedNotes.value =
            Set.from(List.generate(notes.value.length, (index) => index));
      }
    }

    void deleteSelectedNotes() {
      final selectedNotesList = selectedNotes.value.toList();
      for (final index in selectedNotesList) {
        final trashedNote = Trash(
          deletedTitle: notes.value[index].title,
          deletedBody: notes.value[index].body,
        );
        bin.value = [...bin.value, trashedNote];
      }

      notes.value = notes.value
          .asMap()
          .entries
          .where((entry) => !selectedNotes.value.contains(entry.key))
          .map((entry) => entry.value)
          .toList();

      selectedNotes.value = {};
      isSelectionMode.value = false;
      _saveNotes(); // Save after deletion
    }

    void _showDeleteConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Warning',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        deleteSelectedNotes();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Move to bin',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            content: Text(
                'Are you sure you want to delete ${selectedNotes.value.length} note(s)?'),
            actions: [],
          );
        },
      );
    }

    useEffect(() {
      scrollController.addListener(() {
        double offset = scrollController.offset;
        double largeOpacity = 1.0 - (offset / 100);
        double smallOpacity = offset / 200;

        opacityLarge.value = largeOpacity.clamp(0.0, 1.0);
        opacitySmall.value = smallOpacity.clamp(0.0, 1.0);
      });
      return null;
    }, [scrollController]);

    void addNote(Note note) {
      notes.value = [...notes.value, note];
      _saveNotes(); // Save after adding
    }

    replaceNote(Note replaceNote, int index) {
      final newNotes = List<Note>.from(notes.value);
      newNotes[index] = replaceNote;
      notes.value = newNotes;
      _saveNotes(); // Save after replacing
    }

    void _showViewPopup(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Grid(small)'),
                  onTap: () {
                    gridSize.value = 'small';
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Grid(medium)'),
                  onTap: () {
                    gridSize.value = 'medium';
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('Grid(large)'),
                  onTap: () {
                    gridSize.value = 'large';
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    int getCrossAxisCount() {
      switch (gridSize.value) {
        case 'small':
          return 4;
        case 'large':
          return 2;
        default:
          return 3;
      }
    }

    double getChildAspectRatio() {
      switch (gridSize.value) {
        case 'small':
          return 0.8;
        case 'large':
          return 0.6;
        default:
          return 0.7;
      }
    }

    return Scaffold(
      key: NotesDrower.drowerKey,
      drawer: NotesDrower(
        moveToBin: restoreNoteToHomePage,
        bin: bin.value,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            expandedHeight: 250.0,
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double opacity =
                    ((constraints.biggest.height - kToolbarHeight) / 100)
                        .clamp(0.0, 1.0);
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Opacity(
                      opacity: opacity,
                      child: Text(
                        isSelectionMode.value
                            ? "${selectedNotes.value.length} Selected"
                            : "All Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            pinned: true,
            toolbarHeight: 50,
            title: AnimatedOpacity(
              opacity: opacitySmall.value,
              duration: Duration(milliseconds: 100),
              child: Text(
                isSelectionMode.value
                    ? "${selectedNotes.value.length} Selected"
                    : "All Notes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.picture_as_pdf)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(child: Text("Edit"), value: 'edit'),
                  PopupMenuItem(child: Text("View"), value: 'view'),
                  PopupMenuItem(child: Text("Unpin"), value: 'unpin'),
                ],
                onSelected: (value) {
                  if (value == 'view') {
                    _showViewPopup(context);
                  }
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(shadowColor: null),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Text("Date modified"),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_downward)),
                      ],
                    ),
                  ),
                  if (isSelectionMode.value)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: selectAll,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedNotes.value.length ==
                                      notes.value.length
                                  ? Colors.black
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: selectedNotes.value.length ==
                                      notes.value.length
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    height: MediaQuery.of(context).size.height - 50,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: getCrossAxisCount(),
                        childAspectRatio: getChildAspectRatio(),
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: notes.value.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedNotes.value.contains(index);

                        return GestureDetector(
                          onLongPress: () {
                            if (!isSelectionMode.value) {
                              isSelectionMode.value = true;
                              toggleSelection(index);
                            }
                          },
                          onTap: () {
                            if (isSelectionMode.value) {
                              toggleSelection(index);
                            }
                          },
                          child: Stack(
                            children: [
                              NoteCard(
                                note: notes.value[index],
                              ),
                              if (isSelectionMode.value)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isSelectionMode.value &&
              selectedNotes.value.isNotEmpty
          ? Container(
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionItem(Icons.delete_outline, 'Delete', () {
                    _showDeleteConfirmationDialog();
                  }),
                  _buildActionItem(Icons.copy, 'Copy', () {}),
                  _buildActionItem(Icons.share_outlined, 'Share', () {}),
                  _buildActionItem(Icons.archive_outlined, 'Archive', () {}),
                  _buildActionItem(Icons.label_outline, 'Labels', () {}),
                ],
              ),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNote(),
            ),
          ).then((note) {
            if (note != null) {
              addNote(note);
            }
          });
        },
        child: Icon(Icons.edit_document),
      ),
    );
  }
}
