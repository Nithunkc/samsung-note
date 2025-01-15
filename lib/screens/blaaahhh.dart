// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:note_app/drawer.dart';
// import 'package:note_app/create_note.dart';
// import 'package:note_app/note_models.dart';
// import 'package:note_app/screens/update.dart';
// class HomePage extends HookWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final notes = useState<List<Note>>([]);
//     final opacityLarge = useState(1.0);  
//     final opacitySmall = useState(0.0);  
//     final scrollController = useScrollController();
//     final gridSize = useState('size'); 

  
//     useEffect(() {
//       scrollController.addListener(() {
//         double offset = scrollController.offset;
//         double largeOpacity = 1.0 - (offset / 100);  
//         double smallOpacity = offset / 200;  

//         opacityLarge.value = largeOpacity.clamp(0.0, 1.0);
//         opacitySmall.value = smallOpacity.clamp(0.0, 1.0);
//       });
//       return null;
//     }, [scrollController]);

//     void addNote(Note note) {
//       notes.value.add(note);
//     }

//     replaceNote(Note replaceNote, int index) {
//       notes.value[index] = replaceNote;
//     }

//     void _showViewPopup(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   title: Text('Grid(small)'),
//                   onTap: () {
//                     gridSize.value = 'small';
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Grid(medium)'),
//                   onTap: () {
//                     gridSize.value = 'medium';
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Grid(large)'),
//                   onTap: () {
//                     gridSize.value = 'large';
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Close'),
//               ),
//             ],
//           );
//         },
//       );
//     }

//     int getCrossAxisCount() {
//       switch (gridSize.value) {
//         case 'small':
//           return 4;
//         case 'large':
//           return 2;
//         default:
//           return 3;
//       }
//     }

//     double getChildAspectRatio() {
//       switch (gridSize.value) {
//         case 'small':
//           return 0.8;
//         case 'large':
//           return 0.6;
//         default:
//           return 0.7;
//       }
//     }

//     return Scaffold(
//       key: NotesDrower.drowerKey,
//       drawer: const NotesDrower(),
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: CustomScrollView(
//         controller: scrollController,
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Theme.of(context).colorScheme.surface,
//             expandedHeight: 250.0,
//             pinned: false,
//             floating: true,
//             automaticallyImplyLeading: false,
//             flexibleSpace: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 final double opacity = ((constraints.biggest.height- kToolbarHeight) / 100).clamp(0.0, 1.0);

//                 return FlexibleSpaceBar(
//                   centerTitle: true,
//                   title: Padding(
//                     padding: const EdgeInsets.only(bottom: 50),
//                     child: Opacity(
//                       opacity: opacity,
//                       child: Text(
//                         "All Notes",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 32.0,
//                         ),
//                       ),
//                     ),
//                  ),
//                 );
//               },
//             ),
//           ),
//           SliverAppBar(
//             backgroundColor: Theme.of(context).colorScheme.surface,
//             pinned: true,
//             toolbarHeight: 50,
//             title: AnimatedOpacity(
//               opacity: opacitySmall.value,
//               duration: Duration(milliseconds: 100),
//               child: Text(
//                 "All Notes",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             actions: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.picture_as_pdf)),
//               IconButton(onPressed: () {}, icon: Icon(Icons.search)),
//               PopupMenuButton(
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     child: Text("Edit"),
//                     value: 'edit',
//                   ),
//                   PopupMenuItem(
//                     child: Text("View"),
//                     value: 'view',
//                   ),
//                   PopupMenuItem(
//                     child: Text("Unpin"),
//                     value: 'unpin',
//                   ),
//                 ],
//                 onSelected: (value) {
//                   if (value == 'view') {
//                     _showViewPopup(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               color: Theme.of(context).colorScheme.surface,
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(shadowColor: null),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.sort,
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                               Text("Date modified"),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {}, icon: Icon(Icons.arrow_downward)),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     color: Theme.of(context).colorScheme.surface,
//                     height: MediaQuery.of(context).size.height - 50,
//                     child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: getCrossAxisCount(),
//                         childAspectRatio: getChildAspectRatio(),
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                       ),
//                       itemCount: notes.value.length,
//                       itemBuilder: (context, index) {
//                         return NoteCard(
//                           note: notes.value[index],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateNote(),
//             ),
//           ).then((note) {
//             if (note != null) {
//               addNote(note);
//             }
//           });
//         },
//         child: Icon(Icons.edit_document),
//       ),
//     );
//   }
// }




