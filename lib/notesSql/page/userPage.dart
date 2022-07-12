// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:regeasy/about/about.dart';
import '../db/user_database.dart';
import '../model/User.dart';
import '../widget/babyCard.dart';
import 'edit_user_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late List<UserModels>? userModels;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshUserPage();
  }

  @override
  void dispose() {
    RegDatabase.instance.close();
    super.dispose();
  }

  refreshUserPage() async {
    setState(() => isLoading = true);
    userModels = (await RegDatabase.instance.readAllNotes()).cast<UserModels>();
    userModels?.forEach((element) {
      log('${element.id}');
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendees',
            style: TextStyle(fontSize: 24),
          ),
           actions: [
             IconButton(
             icon: Icon(Icons.settings),

              onPressed: () { Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      About()));

              },

             )],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : userModels?.isEmpty ?? true
                  ? const Text(
                      'No Data',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : ListView.builder(
                      itemCount: userModels!.length,
                      padding: const EdgeInsets.only(top: 10.0),
                      itemBuilder: (context, index) {
                        var model = userModels![index];
                        return BabyCard(model, onEdit: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddEditUserPage(userModels: model)));
                          refreshUserPage();
                        }, onDelete: () async {
                          await RegDatabase.instance
                              .delete(userModels![index].id ?? -1);
                          refreshUserPage();
                        });
                      }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditUserPage()),
            );

            refreshUserPage();
          },
        ),
      );
}
