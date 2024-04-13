import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import 'package:todolist/models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({
    super.key,
    required this.onNewNoteCreated,
  });

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  Color titleColor = Colors.black; // Separate color for title
  Color bodyColor = Colors.black; // Separate color for body
  File? pickedImage; // To store picked image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(
                fontSize: 28,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                color: titleColor, // Apply title color
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bodyController,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                color: bodyColor, // Apply body color
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Your Story",
              ),
            ),
            const SizedBox(height: 20),
            if (pickedImage != null)
              Expanded(
                child: Image.file(pickedImage!),
              ), // Display picked image
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty || bodyController.text.isEmpty) {
            return;
          }

          final note = Note(
            body: bodyController.text,
            title: titleController.text,
            // Since signature is now managed in HandwriteScreen, pass null here
            signature: null,
            image: pickedImage?.path,
          );

          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              isBold = !isBold;
              isItalic = false; // Reset italic state
            });
          },
          icon: Icon(
            isBold ? Icons.format_bold : Icons.format_bold_outlined,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isItalic = !isItalic;
              isBold = false; // Reset bold state
            });
          },
          icon: Icon(
            isItalic ? Icons.format_italic : Icons.format_italic_outlined,
          ),
        ),
        IconButton(
          onPressed: () {
            _showColorPicker();
          },
          icon: const Icon(Icons.format_color_text),
        ),
        IconButton(
          onPressed: () {
            _openImagePicker(); // Call method to open image picker
          },
          icon: const Icon(Icons.attach_file), // Use a suitable attachment icon
        ),
        IconButton(
          onPressed: () {
            // Navigate to screen for handwriting
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HandwriteScreen(),
              ),
            );
          },
          icon: const Icon(Icons.edit), // Active handwriting icon
        ),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor:
                  titleController.text.isEmpty ? titleColor : bodyColor,
              onColorChanged: (color) {
                setState(() {
                  if (titleController.text.isEmpty) {
                    titleColor = color;
                  } else {
                    bodyColor = color;
                  }
                });
              },
              // ignore: deprecated_member_use
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }
}

class HandwriteScreen extends StatefulWidget {
  const HandwriteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HandwriteScreenState createState() => _HandwriteScreenState();
}

class _HandwriteScreenState extends State<HandwriteScreen> {
  @override
  Widget build(BuildContext context) {
    return HandwriteCanvas(
      onChanged: (signature) {
        setState(() {});
      },
    );
  }
}

class HandwriteCanvas extends StatefulWidget {
  final void Function(Signature) onChanged; // Add onChanged parameter

  const HandwriteCanvas({super.key, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _HandwriteCanvasState createState() => _HandwriteCanvasState();
}

class _HandwriteCanvasState extends State<HandwriteCanvas> {
  @override
  Widget build(BuildContext context) {
    return Signature(
      strokeWidth: 5.0, // Set the pen stroke width
      onSign: widget.onChanged, // Pass onChanged callback
    );
  }
}
