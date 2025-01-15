import 'package:flutter/material.dart';

class SharedNotes extends StatelessWidget {
  const SharedNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back)),
        title:const Text("Shared notes"),
      ),
    );
  }
}