import 'dart:typed_data';

import 'package:todolist/widgets_notepad.dart/note_view.dart';

class Note {
  final String title;
  final String body;
  final Uint8List? signature;
  final String? image;
  final int? backgroundColor;

  Note({
    required this.title,
    required this.body,
    this.signature,
    this.image,
    this.backgroundColor,
  });

  Type toMap() {
    return (NoteView);
  }
}
