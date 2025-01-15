
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note_app/manage_folder.dart';
import 'package:note_app/recycle_notes.dart';
import 'package:note_app/screens/folder.dart';
import 'package:note_app/screens/recycle_bin.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/drawer_models.dart';
import 'package:note_app/screens/shared_notes.dart';
import 'package:note_app/drawer_themes.dart';

class NotesDrower extends HookWidget {
  static final GlobalKey<ScaffoldState> drowerKey = GlobalKey();

  final List<Trash> bin;
  final Function moveToBin;
  
  // final int index;

  const NotesDrower({
    super.key,
    required this.bin,
    required this.moveToBin
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            ListTile(
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  icon: Icon(Icons.settings)),
            ),
            DrawerContainer(
                destination: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.library_books_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "All Notes",
                      style: drawerContent,
                    )
                  ],
                )),
            DrawerContainer(
                destination: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SharedNotes()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Shared Notes",
                      style: drawerContent,
                    )
                  ],
                )),
            DrawerContainer(
                destination: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Recyclebin(
                              bin: bin,restoreNoteToHomePage: moveToBin,
                              // index: index,
                            )),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Recycle Bin",
                      style: drawerContent,
                    )
                  ],
                )),
            Divider(
              endIndent: 10,
              indent: 10,
            ),
            DrawerContainer(
                destination: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Floder()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Folder",
                      style: drawerContent,
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageFolder()),
                  );
                },
                child: Text(
                  "Manage Folders",
                  style: drawerContent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}