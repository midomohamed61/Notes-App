import 'dart:js';

import 'package:fire/note/view_note.dart';
import 'package:fire/widgets/custom_button_auth.dart';
import 'package:fire/widgets/custom_text_field_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNotes extends StatefulWidget {
  AddNotes({super.key, required this.docId});
  final String docId;
  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();

  bool isLoading = false;

  addNotes() async {
    CollectionReference categories = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docId)
        .collection('note');

    if (formstate.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await categories.add({
          'name': note.text,
        });
        Navigator.of(context as BuildContext).push(
            MaterialPageRoute(
                builder: (context) => NoteView(categoryId: widget.docId)),
            );
      } catch (e) {
        isLoading = false;
        setState(() {});
        print(e);
      }
    }
  }

  //dispose is required
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Form(
        key: formstate,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: CustomTextFormAdd(
                      hinttext: 'Enter your Name',
                      mycontroller: note,
                      valid: (val) {
                        if (val!.isEmpty) {
                          return "Can not be Empty";
                        }
                      }),
                ),
                CustomButtonAuth(
                  title: 'Add',
                  onPressed: () {
                    addNotes();
                  },
                ),
              ]),
      ),
    );
  }
}
