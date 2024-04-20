import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app_with_hive/constants.dart';
import 'package:notes_app_with_hive/models/note_model.dart';

part 'add_notes_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());
  

  addNote(NoteModel note) async {
    emit(AddNotesLoading());
    try {
      var notesBox = Hive.box(kNotesBox);
      await notesBox.add(note);
      emit(AddNotesSuccess());
    } on Exception catch (e) {
      AddNotesFailure(e.toString());
    }
  }
}