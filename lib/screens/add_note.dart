import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_providers.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note_model.dart';

class AddNote extends StatefulWidget {

  bool forUpdate;
  NoteModel? note;

  AddNote({Key? key,required this.forUpdate , this.note}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  FocusNode focusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote(){
    NoteModel newNote = NoteModel(
      id: const Uuid().v1(),
      userId: 'kalash27k@gmail.com',
      title: titleController.text,
      content: contentController.text,
      date: DateTime.now()
    );
    Provider.of<NotesProviders>(context, listen: false).addNote(newNote);
  }

  @override
  void initState() {
    super.initState();
    if(widget.forUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              icon: Icon(Icons.done),
              onPressed: (){
                if(widget.forUpdate){
                  widget.note!.title = titleController.text;
                  widget.note!.content = contentController.text;
                  widget.note!.date = DateTime.now();
                  Provider.of<NotesProviders>(context,listen: false).updateNote(widget.note!);
                }else{
                  addNewNote();
                }
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (val){
                focusNode.requestFocus();
              },
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 28,color: Colors.black),
              autofocus: (widget.forUpdate) ?false :true,
              decoration: const InputDecoration(
                hintText: 'Title'
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: focusNode,
                style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic, color: Colors.grey[700]),
                decoration: const InputDecoration(
                  hintText: 'Content',
                  border: InputBorder.none
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}