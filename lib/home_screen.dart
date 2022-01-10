import 'package:flutter/material.dart';
import 'package:sqflite_86/database_helper.dart';
import 'package:sqflite_86/grocery.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  int? selectId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_controller.text);

          setState(() {
            if (selectId == null) {
              DatabaseHelper.instance.add(Grocery(name: _controller.text));
            } else {
              DatabaseHelper.instance
                  .update(Grocery(name: _controller.text, id: selectId));
              selectId = null;
            }
            _controller.text = '';
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: TextField(
          controller: _controller,
        ),
      ),
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
                return Card(
                  child: ListTile(
                    onLongPress: () {
                      setState(() {
                        DatabaseHelper.instance.remove(e.id!);
                      });
                    },
                    onTap: () {
                      _controller.text = e.name;
                      selectId = e.id;
                    },
                    title: Text(e.name),
                    subtitle: Text(e.id.toString()),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
