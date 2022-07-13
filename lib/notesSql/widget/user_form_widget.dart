import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final int? id;
  final String? name;
  final String? age;
  final String? gender;
  final String? church;
  final String? churchCity;
  final String? churchState;

  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedAge;
  final ValueChanged<String> onChangedGender;
  final ValueChanged<String> onChangedChurch;
  final ValueChanged<String> onChangedChurchCity;
  final ValueChanged<String> onChangedChurchState;

  const NoteFormWidget({
    Key? key,
    required this.onChangedName,
    required this.onChangedAge,
    required this.onChangedGender,
    required this.onChangedChurch,
    required this.onChangedChurchCity,
    required this.onChangedChurchState,
    this.id,
    this.name,
    this.age,
    this.gender,
    this.church,
    this.churchCity,
    this.churchState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform== TargetPlatform;

    return SingleChildScrollView(
 child:      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(
                label: Text('Name'),

                hintText: 'Enter Name',
                prefixIcon: Icon(
                  Icons.notes,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (name) =>
              name != null && name.isEmpty
                  ? 'The name cannot be empty'
                  : null,
              onChanged: onChangedName,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: age,
              decoration: const InputDecoration(
                label: Text('Age'),
                hintText: 'Enter Age',
                prefixIcon: Icon(
                  Icons.access_time,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (age) =>
              age != null && age.isEmpty
                  ? 'The age cannot be empty'
                  : null,
              onChanged: onChangedAge,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: gender,
              decoration: const InputDecoration(
                label: Text('Gender'),
                hintText: 'Enter Gender',
                prefixIcon: Icon(
                  Icons.accessibility,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (gender) =>
              gender != null && gender.isEmpty
                  ? 'The age cannot be empty'
                  : null,
              onChanged: onChangedGender,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: church,
              decoration: const InputDecoration(
                label: Text('Church'),
                hintText: 'Enter Church',
                prefixIcon: Icon(
                  Icons.home,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (gender) =>
              gender != null && gender.isEmpty
                  ? 'The gender cannot be empty'
                  : null,
              onChanged: onChangedChurch,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: churchCity,
              decoration: const InputDecoration(
                label: Text('Church City'),
                hintText: 'Enter Church City',
                prefixIcon: Icon(
                  Icons.add_business,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (churchCity) =>
              churchCity != null && churchCity.isEmpty
                  ? 'The Church City cannot be empty'
                  : null,
              onChanged: onChangedChurchCity,
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: churchState,
              decoration: const InputDecoration(
                label: Text('Church State'),
                hintText: 'Enter Church State',
                prefixIcon: Icon(
                  Icons.refresh,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (churchState) =>
              churchState != null && churchState.isEmpty
                  ? 'The Church State cannot be empty'
                  : null,
              onChanged: onChangedChurchState,
            ),
            //SizedBox(height: 15,),
          ],
        ),
      )

    );
  }
}
