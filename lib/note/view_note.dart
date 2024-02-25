import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/categories/edit.dart';
import 'package:fire/note/add_note.dart';
import 'package:fire/note/edit_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key, required this.categoryId});

  final String categoryId;
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('note')
        .get();
    await Future.delayed(Duration(seconds: 2));
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNotes(docId: widget.categoryId)));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Note'),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: PopScope(
          child: isLoading == true
              ? CircularProgressIndicator()
              : GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 160),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Warning',
                            desc: 'Are you sure?',
                            btnCancelText: 'delete',
                            btnOkText: 'edit',
                            btnCancelOnPress: () async {},
                            btnOkOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc(widget.categoryId)
                                  .collection('note')
                                  .doc(data[index].id)
                                  .delete();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NoteView(categoryId: widget.categoryId)));
                            }).show();
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNote(
                                noteDocId: data[index].id,
                                categoryeDocId: widget.categoryId,
                                value: data[index]['note'])));
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [Text('${data[index]['note']}')],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
