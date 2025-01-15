import 'package:flutter/material.dart';

class AllNotes extends StatelessWidget {
  const AllNotes ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("All Notes"),
      ),
    );
  }
}
