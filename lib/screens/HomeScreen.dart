import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/models/Note.dart';
import 'package:notesapp/providers/NoteCollection.dart';
import 'package:notesapp/screens/NoteScreen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  var collection = NoteCollection();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            if (notes.count == 0) return Text('Notes');
            return Text(
              'Notes (${notes.count})'
            );
          },
        )
      ),
      body: _buildNotesList(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Note note = Note(
            id: new Uuid().v4(),
          );
          Provider.of<NoteCollection>(context, listen: false).addNote(note);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: note,
              )
            )
          );
        },
      ),
    );
  }

  Widget _buildNotesList() {

    return Consumer<NoteCollection>(
      builder: (context, notes, child) {
        var allNotes = notes.allNotes;

        if (allNotes.length == 0) {
          return (
              Center(
                child: Text(
                    'No Notes',
                ),
              )
          );
        }

        return ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            var note = allNotes[index];

            return Dismissible(
              key: Key(note.id),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                Provider.of<NoteCollection>(context, listen: false).removeNote(note.id);
              },
              child: ListTile(
                title: Text(note.body),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(
                        note: note,
                      )
                    )
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
