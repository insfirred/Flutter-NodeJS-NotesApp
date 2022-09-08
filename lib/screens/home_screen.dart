import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/provider/notes_providers.dart';
import 'package:provider/provider.dart';

import './add_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    NotesProviders notesProviders = Provider.of<NotesProviders>(context);

    return Scaffold(
      body: (notesProviders.isLoading) ?Center(child: CircularProgressIndicator())
      : (notesProviders.noteList.length > 0) ?GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: notesProviders.noteList.length,
        itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                //update
                Navigator.push(context, CupertinoPageRoute(fullscreenDialog: true,builder: (context) => AddNote(forUpdate: true, note: notesProviders.noteList[index],)));
              },
              onLongPress: (){
                //delete
                notesProviders.deleteNode(notesProviders.noteList[index]);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 800),content: Text('Note Removed')));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                ),
                width: 100,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notesProviders.noteList[index].title! , style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    Text(notesProviders.noteList[index].content! , style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,color: Colors.grey[700]),maxLines: 5,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ),
            ),
          );
        },
      ) :Center(child: Text('No Notes Yet, Click on + to start adding')),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(
            fullscreenDialog: true,
            builder:(context) => AddNote(forUpdate: false,)
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}