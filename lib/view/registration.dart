import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var emailcon = TextEditingController();
  var passcon = TextEditingController();
  var cpasscon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var psw;

  bool showpass1 = true;
  bool showpas = true;

  late SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Image(image: AssetImage("assets/image/todolog.jpg")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (em) {
                    if (em!.isEmpty ||
                        !em.contains("@") ||
                        !em.contains("gmail.com")) {
                      return "invalid format";
                    }
                  },
                  controller: emailcon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (password) {
                    psw = password;
                    if (password!.isEmpty) {
                      return "This field must be filled";
                    } else if (password.length < 5) {
                      return "Atleast 5 characters must be given";
                    }
                  },
                  obscuringCharacter: "*",
                  obscureText: showpas,
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
                          icon: showpas == false
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (cp) {
                    if (cp != psw) {
                      return "password is not same";
                    }
                  },
                  controller: cpasscon,
                  obscuringCharacter: "*",
                  obscureText: showpass1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Confirm Password"),
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (showpass1 == true) {
                                showpass1 = false;
                              } else {
                                showpass1 = true;
                              }
                            });
                          },
                          icon: showpass1 == false
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off))),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.grey),
                          children: [
                        TextSpan(text: "Already have an account "),
                        TextSpan(
                            text: "SignIn",
                            style: TextStyle(color: Colors.blue))
                      ]))),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                shape: StadiumBorder(),
                color: Colors.green,
                onPressed: () {
                  var valid = formkey.currentState!.validate();
                  if (valid == true) {
                    storedata(emailcon.text, passcon.text);

                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void storedata(String emaill, String passs) async {
    pref = await SharedPreferences.getInstance();

    await pref.setString("emailname", emaill);
    await pref.setString("passname", passs);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Login()));
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Successfully registered")));
  }
}
