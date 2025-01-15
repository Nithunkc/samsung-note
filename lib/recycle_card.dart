import 'package:flutter/material.dart';
import 'package:note_app/recycle_notes.dart';

class BinnedNoteCard extends StatelessWidget {
  final Trash bin;
  final int index;

  const BinnedNoteCard({super.key, required this.bin, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 160.0,
            minWidth: 100,
          ),
          child: Card(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.start,
                  bin.deletedBody,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            bin.deletedTitle,
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