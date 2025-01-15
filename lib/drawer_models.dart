import 'package:flutter/material.dart';
import 'package:note_app/drawer_themes.dart';

class DrawerContainer extends StatelessWidget {
  final VoidCallback destination;
  final Widget child;
  const DrawerContainer(
      {super.key, required this.child, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: AppPadding().DrowerContentPadding,
      child: GestureDetector(
        onTap: destination,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
         padding: AppPadding().DrowerContentPadding,
          child: child,
        ),
      ),
    );
  }
}



class Note {
  final String title;
  final String body;

  Note({required this.title, required this.body});
}

class NoteCard extends StatelessWidget {
  final Note note; // Note data

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Container(
          constraints: BoxConstraints(
            minHeight: 170.0, 
            minWidth: 100,
          ),
          child: Card(
            margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity, 
                child: Text(
                  note.body,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Text(
            note.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            softWrap: true, 
            overflow: TextOverflow.ellipsis, 
          ),
        ),
      ],
    );
  }
}


