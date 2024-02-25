import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/categories/edit.dart';
import 'package:fire/note/view_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
    //we made where to know who is own the account و عشان مايحصلش بظرميط و كله يبقا في جهازه
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
            Navigator.of(context).pushNamed('addCategories');
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('HomePage'),
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
        body: isLoading == true
            ? CircularProgressIndicator()
            : GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 160),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteView(categoryId: data[index].id)));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Warning',
                          desc: 'what do you want?',
                          btnCancelText: 'delete',
                          btnOkText: 'edit',
                          btnCancelOnPress: () async {
                            //data[index].id important to know wich one will be deleted
                            await FirebaseFirestore.instance
                                .collection('categories')
                                .doc(data[index].id)
                                .delete();
                            Navigator.of(context)
                                .pushReplacementNamed('homepage');
                            print('ok');
                          },
                        btnOkOnPress: () async{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCategory(docId: data[index].id, oldName: data[index]['name'])));
                        }
                      ).show();
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 100,
                                ),
                                Text('${data[index]['name']}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
