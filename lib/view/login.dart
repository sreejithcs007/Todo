import 'package:firebasesample/view/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailcon = TextEditingController();
  var passcon = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool showpas = false;

  late SharedPreferences pref ;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage("assets/image/todolog.jpg")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 8,right: 8),
                child: TextFormField(
                  validator: (em){
                    if(em!.isEmpty ){
                      return " This field must be filled";
                    }
                    else{
                      return null;
                    }
                  },
                  controller: emailcon,
                  decoration: InputDecoration(
                      label: Text("Email"),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 8,right: 8),
                child: TextFormField(
                  validator: (psw){
                    if(psw!.isEmpty){
                      return "This field is required";
                    }
                    else{
                      return null;
                    }
                  },
                  controller: passcon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (showpas == true) {
                                showpas = false;
                              } else {
                                showpas = true;
                              }
                            });
                          },
                          icon: showpas == true
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Registration()));
                  },
                  child: RichText(
                      text:
                          TextSpan(style: TextStyle(color: Colors.grey,fontSize: 15), children: [
                    TextSpan(text: "Don't have an account "),
                    TextSpan(text: "Signup", style: TextStyle(color: Colors.blue))
                  ]))),
              MaterialButton(
                shape: StadiumBorder(),
                minWidth: MediaQuery.of(context).size.width*0.5,
                color: Colors.green,
                onPressed: () {
                  var valid = formkey.currentState!.validate();
                  if(valid == true){
                    getdata(emailcon.text,passcon.text);
                  }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid input"),backgroundColor: Colors.green,));
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getdata(String lemail, String lpass) async{

    pref = await SharedPreferences.getInstance();

    var em = pref.getString("emailname");
    var pss = pref.getString("passname");

    if(lemail == em && lpass == pss){

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid email or password"),backgroundColor: Colors.green,));
    }


  }
}
