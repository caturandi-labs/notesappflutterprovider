import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/models/Note.dart';
import 'package:notesapp/providers/NoteCollection.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note _note;
  NoteScreen({Key key, note}): _note = note;

  @override
  State<StatefulWidget> createState() {
    return _NoteScreenState(
      note: _note
    );
  }
}

class _NoteScreenState extends State<NoteScreen> {
  final Note _note;
  _NoteScreenState({Key key, note}): _note = note;

  final TextEditingController bodyController = TextEditingController();

  void initState () {
    super.initState();

    debugPrint("Note from init state : " + _note.id + ' - ' + _note.body);
    debugPrint("text ctrl " + bodyController.text);
    bodyController.text = _note.body;

    bodyController.addListener(() {
      debugPrint('Body Controller Listener == ' + bodyController.text);
      Provider.of<NoteCollection>(context, listen: false).updateNote(
        _note.id,
        bodyController.text
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            debugPrint(notes.getNote(_note.id).noteBody);
            return Text(
              notes.getNote(_note.id).noteBody
            );
          },
        )
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Start writing your note here',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20.0)
                ),
              ),
            )
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              padding: EdgeInsets.all(20.0),
              child: Consumer<NoteCollection>(
                builder: (context, notes, child) {
                  Note note = notes.getNote(_note.id);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${note.characters} Characters',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        '${note.words} Words',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}
