import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatelessWidget {
  var titlecon = TextEditingController();
  var subcon = TextEditingController();
var dbt =  FirebaseFirestore.instance.collection("employee");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titlecon,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Title"),
                hintText: "Title",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
              top: 20,
            ),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              controller: subcon,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Due Date"),
                hintText: "dd-MM-yyyy",

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  shape: StadiumBorder(),
                  color: Colors.green,
                  onPressed: () {


                    dbt.add({"title" : titlecon.text,"subtitle": subcon.text });

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add Task ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  shape: StadiumBorder(),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel ",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
