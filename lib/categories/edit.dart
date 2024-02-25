import 'dart:js';

import 'package:fire/widgets/custom_button_auth.dart';
import 'package:fire/widgets/custom_text_field_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategory extends StatefulWidget {
  EditCategory({super.key, required this.docId, required this.oldName});
  final String docId;
  final String oldName;
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  bool isLoading = false;

  editCategories() async{
    if (formstate.currentState!.validate()) {
      try{
        isLoading = true;
        setState(() {

        });
          await categories.doc(widget.docId).update({
            'name':name.text
          });

        Navigator.of(context as BuildContext).pushNamedAndRemoveUntil('homepage',(route) => false);
      }
      catch(e){
        isLoading = false;
        setState(() {

        });
        print(e);
      }
    }
  }

  void initState(){
    name.text = widget.oldName;
    super.initState();
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
                mycontroller: name,
                valid: (val) {
                  if (val!.isEmpty) {
                    return "Can not be Empty";
                  }
                }),
          ),
          CustomButtonAuth(
            title: 'Edit',
            onPressed: () {
              editCategories();
            },
          ),
        ]),
      ),
    );
  }
}
