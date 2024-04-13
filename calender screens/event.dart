class Event {
  int? id;
  String? title;
  DateTime? date;
  String? description;

  Event({this.id, this.title, this.date, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date?.toIso8601String(),
      'description': description,
    };
  }
}
