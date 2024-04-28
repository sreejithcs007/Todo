import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasesample/view/taskpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  var db = FirebaseFirestore.instance.collection("employee");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskPage()));
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: db.orderBy("title").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Todo",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.grey,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                    
                    
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text("Title : ${snapshot.data!.docs[index]["title"]}"),
                            subtitle: Text("Due date : ${snapshot.data!.docs[index]["subtitle"]}"),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
