import 'package:fire/widgets/custom_button_auth.dart';
import 'package:fire/widgets/custom_text_field_add.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategories extends StatelessWidget {
  AddCategories({super.key});
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  Future<void> addCategories() {
    return categories
        .add({
      'name': name.text,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Categories'),
      ),
      body: Form(
        key: formstate,
        child: Column(children: [
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
