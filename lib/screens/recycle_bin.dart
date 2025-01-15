import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_storage/get_storage.dart';  // Add this import
import 'package:note_app/recycle_card.dart';
import 'package:note_app/recycle_notes.dart';
import 'package:note_app/note_models.dart';

class Recyclebin extends HookWidget {
  final List<Trash> bin;
  final Function restoreNoteToHomePage;

  const Recyclebin({
    super.key,
    required this.bin,
    required this.restoreNoteToHomePage,
  });

  @override
  Widget build(BuildContext context) {
    final binState = useState<List<Trash>>(bin);


    final storage = GetStorage();

    
    useEffect(() {
      storage.write('bin', binState.value);
      return null;
    }, [binState.value]);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            expandedHeight: 250.0,
            pinned: false,
            floating: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Opacity(
                  opacity: 1.0,
                  child: Text(
                    "Recycle Bin",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            pinned: true,
            toolbarHeight: 50,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.menu)),
            title: Title(
              color: Theme.of(context).colorScheme.surface,
              child: Text("Recycle Bin"),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                height: MediaQuery.of(context).size.height - 50,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: binState.value.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          _showWarningDialog(context, binState, index);
                        },
                        child: BinnedNoteCard(
                          bin: binState.value[index],
                          index: index,
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWarningDialog(BuildContext context, ValueNotifier<List<Trash>> binState, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "              Warning",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _restoreNote(context, binState, index);
              Navigator.pop(context);
            },
            child: Text(
              "Restore",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              binState.value = List.from(binState.value)..removeAt(index);
              Navigator.pop(context);
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _restoreNote(BuildContext context, ValueNotifier<List<Trash>> binState, int index) {
    final restoredNote = binState.value[index]; // Get the trashed note
    final restoredNoteModel = Note(
      title: restoredNote.deletedTitle,
      body: restoredNote.deletedBody,
    );

    restoreNoteToHomePage(restoredNoteModel); // Restore to HomePage

    binState.value = List.from(binState.value)..removeAt(index); // Remove from bin
  }
}
