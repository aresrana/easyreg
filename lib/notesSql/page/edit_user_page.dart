import 'package:flutter/material.dart';

import '../db/user_database.dart';

import '../model/User.dart';
import '../widget/user_form_widget.dart';

class AddEditUserPage extends StatefulWidget {
  final UserModels? userModels;

  const AddEditUserPage({
    Key? key,
    this.userModels,
  }) : super(key: key);
  @override
  _AddEditUserPageState createState() => _AddEditUserPageState();
}

class _AddEditUserPageState extends State<AddEditUserPage> {
  final _formKey = GlobalKey<FormState>();
  int? id;
  String? name;
  String? age;
  String? gender;
  String? church;
  String? churchCity;
  String? churchState;

  @override
  void initState() {
    super.initState();
    if (widget.userModels != null) {
      name = widget.userModels!.name ?? '';
      age = widget.userModels!.age ?? '';
      gender = widget.userModels!.gender ?? '';
      church = widget.userModels!.church ?? '';
      churchCity = widget.userModels!.churchCity ?? '';
      churchState = widget.userModels!.churchState ?? '';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Form(
              key: _formKey,
              child: NoteFormWidget(
                  name: name,
                  age: age,
                  gender: gender,
                  church: church,
                  churchCity: churchCity,
                  churchState: churchState,
                  onChangedName: (name) => this.name = name,
                  onChangedAge: (age) => this.age = age,
                  onChangedChurch: (church) => this.church = church,
                  onChangedGender: (gender) => this.gender = gender,
                  onChangedChurchCity: (churchCity) =>
                      this.churchCity = churchCity,
                  onChangedChurchState: (churchState) =>
                      this.churchState = churchState),
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                                height: 50.0,
              child: MaterialButton(
                color: Colors.white,
                child: const Text(
                  'Save Data',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  addOrUpdateNote();
                },
                //color: Theme.of(context).primaryColor,
              )),
            )
          ])));

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.userModels != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    if (_formKey.currentState!.validate()) {
      final note = widget.userModels!.copyWith(
          name: name,
          age: age,
          gender: gender,
          church: church,
          churchCity: churchCity,
          churchState: churchState);

      await RegDatabase.instance.update(note);
    }
  }

  Future addNote() async {
    var userModel = UserModels(
      name: name,
      age: age,
      gender: gender,
      church: church,
      churchCity: churchCity,
      churchState: churchState,
      createdTime: DateTime.now(),
      id: id,
    );
    await RegDatabase.instance.create(userModel);
  }
}
