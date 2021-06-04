import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/BasedOnliked.dart';
import 'package:frontend/Basedonrating.dart';
import 'package:frontend/loginpage.dart';
import 'package:frontend/output.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showtextfield = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var favmov;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://i0.wp.com/thebutlercollegian.com/wp-content/uploads/2019/03/netflix-image.jpg?w=1920&ssl=1'))),
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                alignment: Alignment.topRight,
                child: HoverWidget(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    height: 50,
                    width: size.width / 7,
                    child: Center(
                      child: Text('premier users',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  hoverChild: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 50,
                    width: size.width / 7,
                    child: Center(
                      child: Text('premier users',
                          style: GoogleFonts.poppins(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  onHover: (e) {},
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showtextfield = !showtextfield;
                  });
                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BasedOnLiked()));*/
                },
                child: HoverWidget(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.red,
                    ),
                    height: 70,
                    width: size.width / 4,
                    child: Center(
                      child: Text('FREE RECOMMENDATION',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  hoverChild: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.black,
                    ),
                    height: 70,
                    width: size.width / 4,
                    child: Center(
                      child: Text('FREE RECOMMENDATION',
                          style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  onHover: (e) {},
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: showtextfield == true
                  ? Container(
                      width: size.width / 2,
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              width: size.width / 3.2,
                              height: 100,
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                    'ENTER THE MOVIE NAME BASED ON WHICH THE RECOMNMENDATION SHOULD BE PROVIDED',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Colors.grey.shade100,
                                        fontWeight: FontWeight.w500,
                                        textStyle: TextStyle())),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                              width: size.width / 3.2,
                              child: TextFormField(
                                  onSaved: (v) {
                                    setState(() {
                                      favmov = v;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'userid cannot be empty';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      favmov = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.amber, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2)))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                print(favmov.toString());
                                if (formkey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Processing Data.............')));

                                  print(favmov.toString());
                                  final response = await http
                                      .post(Uri.http('127.0.0.1:5000', 'favo'),
                                          body: json.encode({
                                            'favmov': favmov.toString(),
                                          }))
                                      .then((v) async {
                                    print('sent successfully');
                                    var response = await http.get(
                                        Uri.http('127.0.0.1:5000', 'favo'));
                                    List<dynamic> data =
                                        json.decode(response.body)['favourite'];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Output(data: data)));
                                  });
                                }
                              },
                              child: Container(
                                child: HoverWidget(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    height: 40,
                                    width: size.width / 8,
                                    child: Center(
                                      child: Text('Enter',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  hoverChild: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    height: 40,
                                    width: size.width / 8,
                                    child: Center(
                                      child: Text('Enter',
                                          style: GoogleFonts.poppins(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  onHover: (e) {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(''),
            )
          ],
        ),
      ),
    ));
  }
}
