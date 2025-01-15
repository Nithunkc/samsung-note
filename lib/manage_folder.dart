import 'package:flutter/material.dart';

class ManageFolder extends StatelessWidget {
  const ManageFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Manage folder",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4.0,
            child: ListTile(
              leading: const Icon(Icons.folder, size: 30.0, color: Colors.black),
              title: const Text(
                "Folder",
                style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
              ),
              onTap: () {
               
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4.0,
            child: ListTile(
              leading: const Icon(Icons.add, size: 30.0, color: Colors.green),
              title: const Text(
                "Create Folder",
                style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
              ),
              onTap: () {
              
              },
            ),
          ),
        ],
      ),
    );
  }
}