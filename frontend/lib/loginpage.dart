import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/premierRecomm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userId, password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool redline = false;
  bool send = false;
  Future<String> getdata() async {
    var response = await http.get(Uri.http('127.0.0.1:5000', 'name'));
    String data = json.decode(response.body) as String;
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://i.imgur.com/OMSRrRS.png'))),
        child: Center(
          child: Container(
            height: 500,
            width: size.width / 2,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Colors.black54),
                    height: 500,
                    width: size.width / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        'https://th.bing.com/th/id/Radb6b7596a16d8b8ac7d22b3ee8f496b?rik=UgfiurVGb0QK8g&riu=http%3a%2f%2fwww.newdesignfile.com%2fpostpic%2f2016%2f05%2fmovie-tickets-vector-free_401932.jpg&ehk=R6SfNQt9oko1kOaCtAXvLrZ8Dkft3d436EY0mpqiRC4%3d&risl=&pid=ImgRaw',
                        height: 500,
                        width: size.width / 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  height: 500,
                  width: size.width / 4,
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text('Login Credentials',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 22)),
                        SizedBox(
                          height: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('UserId',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w300,
                                    textStyle: TextStyle())),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                onSaved: (v) {
                                  v = userId;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'userid cannot be empty';
                                  } else if (value is Characters) {
                                    return 'Invalid';
                                  } else if (int.parse(value) < 0 ||
                                      int.parse(value) > 610) {
                                    return 'Invalid';
                                  } 
                                },
                                onChanged: (value) {
                                  setState(() {
                                    userId = value;
                                  });
                                  print(userId);
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: redline == true
                                                ? Colors.red
                                                : Colors.black26,
                                            width: 0.3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: redline == true
                                                ? Colors.red
                                                : Colors.black54,
                                            width: 1)))),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Password',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w300,
                                    textStyle: TextStyle())),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password cannot be empty';
                                  } else if (value is Characters) {
                                    return 'invalid';
                                  } else if (int.parse(value) < 100 ||
                                      int.parse(value) > 999) {
                                    return 'Invalid';
                                  }
                                },
                                obscureText: true,
                                onSaved: (va) {
                                  password = va;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                  print(password);
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: redline == true
                                                ? Colors.red
                                                : Colors.black26,
                                            width: 0.3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: redline == true
                                                ? Colors.red
                                                : Colors.black54,
                                            width: 1)))),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Premier(
                                            userid: userId,
                                          )));
                            }
                            /*     print(userId);
                            print(password);
                            final response = await http
                                .post(Uri.http('127.0.0.1:5000', '/name'),
                                    body: json.encode({
                                      'userid': userId.toString(),
                                      'password': password.toString()
                                    }))
                                .then((value) {
                              print('send successfully');
                            });
                            
                            */

                            /*      if (userId.length == 3 &&
                                    password.length == 3 &&
                                    int.parse(userId) > 0 ||
                                int.parse(userId) == 0 &&
                                    userId.int.parse(userId) < 611 &&
                                    int.parse(password) > 100 &&
                                    int.parse(password) < 1000) {
                              print('valid go ahead');
                              final response = await http.post(
                                  Uri.http('127.0.0.1:5000', 'name'),
                                  body: json.encode({'userid': userId}));
                            } else {
                              setState(() {
                                redline = true;
                                print('invalid');
                              });
                            }*/
                          },
                          child: Container(
                              height: 50,
                              width: size.width / 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue),
                              child: Center(
                                  child: Text(
                                'LOGIN',
                                style: TextStyle(fontSize: 22),
                              ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
