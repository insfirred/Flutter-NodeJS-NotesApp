import 'package:flutter/cupertino.dart';
import 'package:notes_app/services/api_service.dart';

import '../models/note_model.dart';

class NotesProviders with ChangeNotifier{

  List<NoteModel> noteList = [];
  
  bool isLoading = true;

  NotesProviders(){
    fetchingNotes();
  }

  void sortNotes(){
    noteList.sort((a, b) => b.date!.compareTo(a.date!));
  }

  //Create
  void addNote(NoteModel note){
    noteList.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  // Read
  void fetchingNotes() async{
    noteList = await ApiService.fetchNotes('kalash27k@gmail.com');
    isLoading = false;
    sortNotes();
    notifyListeners();
  }

  // Update
  void updateNote(NoteModel note){
    int noteIndex = noteList.indexOf(noteList.firstWhere((element) => element.id == note.id));
    noteList[noteIndex] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  // Delete
  void deleteNode(NoteModel note){
    int noteIndex = noteList.indexOf(noteList.firstWhere((element) => element.id == note.id));
    noteList.removeAt(noteIndex);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }
}