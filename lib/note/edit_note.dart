import 'dart:js';

import 'package:fire/note/view_note.dart';
import 'package:fire/widgets/custom_button_auth.dart';
import 'package:fire/widgets/custom_text_field_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.noteDocId, required this.categoryeDocId, required this.value});
  final String noteDocId;
  final String value;
  final String categoryeDocId;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();


  bool isLoading = false;

  //set = update if doc is exist
  //set = add if doc don't exist
  //we just will replace update to set and will add SetOptions(merge: ture || false)
  editNote() async{
    CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  if (formstate.currentState!.validate()) {
      try{
        isLoading = true;
        setState(() {

        });
        await categories.doc(widget.categoryeDocId).update({
          'name':note.text
        },
        );
        Navigator.of(context as BuildContext).push(MaterialPageRoute(builder: (context)=>NoteView(categoryId: widget.categoryeDocId)));
      }
      catch(e){
        isLoading = false;
        setState(() {

        });
        print(e);
      }
    }
  }

  @override
  void initState() {
    note.text = widget.value;
    super.initState();
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
        title: Text('Add Categories'),
      ),
      body: Form(
        key: formstate,
        child:isLoading ? Center(child: CircularProgressIndicator(),): Column(children: [
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
            title: 'Edit',
            onPressed: () {
              editNote();
            },
          ),
        ]),
      ),
    );
  }
}
