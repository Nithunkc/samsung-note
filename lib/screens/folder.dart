import 'package:flutter/material.dart';

class Floder extends StatelessWidget {
  const Floder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back)),
        title: const Text("Folder"),
      ),
    );
  }
}