import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference collectionref = FirebaseFirestore.instance.collection("employee");

  var name = TextEditingController();
  var ph = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(),
      body: StreamBuilder(stream: collectionref.snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {

        if(snapshot.hasError){

          return  Center(child: Text('Something went wrong'));
        }
         if(snapshot.connectionState == ConnectionState.waiting) {
          return  Center(child: CircularProgressIndicator());
        }
         return
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextField(
                     controller: name ,
                     decoration: InputDecoration(
                       hintText: "Name",
                       border: OutlineInputBorder(),

                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextField(
                     controller: ph ,
                     decoration: InputDecoration(
                       hintText: "phone number",
                       border: OutlineInputBorder(),

                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SizedBox(
                     height: 50,
                     width:100,
                     child: MaterialButton(onPressed: (){
                       collectionref.add({"name": name.text.trim(),"ph":ph.text.trim()}).then((documentSnapshot) =>
                           print("Added Data with ID: ${documentSnapshot.id}"));

                       name.clear();
                       ph.clear();
                     },
                         color: Colors.yellow
                         , child
                             : Text("add")),
                           ),
                 ),

                 Expanded(
                   child: SizedBox(
                     height: MediaQuery.of(context).size.height*0.5,
                     width: double.infinity,
                     child: ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context,index){
                   
                            return
                                Card(
                   
                                     child: ListTile(
                   
                                       title: Text(snapshot.data!.docs[index]["name"]),
                                       subtitle: Text(snapshot.data!.docs[index]['ph']),
                                       trailing: Wrap(
                                         children: [
                                           IconButton(onPressed: (){
                   
                                          var id =   snapshot.data!.docs[index].id;
                                          collectionref.doc(id).update({"name":"ans","ph":"45"});
                   
                                           }, icon: Icon(Icons.edit)),
                                           IconButton(onPressed: (){
                   
                                             var id = snapshot.data!.docs[index].id;
                                             collectionref.doc(id).delete();
                   
                                           }, icon: Icon(Icons.delete)),
                   
                   
                                         ],
                                       ),
                                     ),
                                   );
                   
                   
                   
                   
                         }),
                   ),
                 ),


               ],
             );


      },),
    );
  }
}
