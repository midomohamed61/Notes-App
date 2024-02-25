import 'dart:js';

import 'package:fire/widgets/custom_button_auth.dart';
import 'package:fire/widgets/custom_text_field_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategories extends StatefulWidget {
  AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  bool isLoading = false;

   addCategories() async{
     if (formstate.currentState!.validate()) {
       try{
         isLoading = true;
         setState(() {

         });
         DocumentReference response = await categories
           .add({
         'name': name.text,
         'id':FirebaseAuth.instance.currentUser!.uid,
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

  //dispose is required
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
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
            title: 'Add',
            onPressed: () {
              addCategories();
            },
          ),
        ]),
      ),
    );
  }
}
