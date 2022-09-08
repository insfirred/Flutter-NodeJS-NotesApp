import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notes_app/models/note_model.dart';

class ApiService{

  static String baseUrl = "https://lit-dawn-31319.herokuapp.com/notes";

  static Future<void> addNote(NoteModel note) async{
    Uri uri = Uri.parse("$baseUrl/add");
    var response = await http.post(uri, body: note.toJson());
    var noteJson = jsonDecode(response.body);
    log(noteJson.toString());
  }

  static Future<List<NoteModel>> fetchNotes(String userId) async{
    Uri uri = Uri.parse("$baseUrl/list");
    var response = await http.post(uri, body: {"userId": userId});
    var noteJson = jsonDecode(response.body);
    log(noteJson.toString());

    List<NoteModel> notesList = [];

    for(var note in noteJson){
      NoteModel newNote = NoteModel.fromJson(note);
      notesList.add(newNote);
    }

    return notesList;
  }

  static Future<void> deleteNote(NoteModel note) async{
    Uri uri = Uri.parse("$baseUrl/delete");
    var response = await http.post(uri, body: note.toJson());
    var noteJson = jsonDecode(response.body);
    log(noteJson.toString());
  }
}