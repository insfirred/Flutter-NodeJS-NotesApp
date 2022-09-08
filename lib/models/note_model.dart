class NoteModel{
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? date;

  NoteModel({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.date
  });

  factory NoteModel.fromJson(Map<String,dynamic> json){
    return NoteModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      content: json["content"],
      date: DateTime.tryParse(json["date"])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "content": content,
      "date": date!.toIso8601String(),
    };
  }
}