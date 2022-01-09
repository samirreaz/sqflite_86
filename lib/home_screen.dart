import 'package:flutter/material.dart';
import 'package:sqflite_86/database_helper.dart';
import 'package:sqflite_86/grocery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Grocery>>(
        future: DatabaseHelper.instance.getGrocery(),
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('no List Found'),
            );
          } else {
            return ListView(
              children: snapshot.data!.map((e) {
                return ListTile(
                  title: Text(e.name),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
