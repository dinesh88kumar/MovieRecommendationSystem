import 'package:flutter/material.dart';
import 'package:frontend/loginpage.dart';
import 'package:frontend/showdata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:js_util';

class Premier extends StatefulWidget {
  var userid;
  Premier({required this.userid});
  @override
  _PremierState createState() => _PremierState();
}

class _PremierState extends State<Premier> {
  bool showdata = false;
/* Future<String> returnfromfutre() async {
    var response = await http.get(Uri.http('127.0.0.1:5000', 'user1'));
    String data = json.decode(response.body)['userid'];
    print(data.toString());
    return data;
  }*/
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Container(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
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
                      width: size.width / 8,
                      child: Center(
                        child: Text('LOGOUT',
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
                      width: size.width / 8,
                      child: Center(
                        child: Text('LOGOUT',
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
            ),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () async {
                final response = await http
                    .post(Uri.http('127.0.0.1:5000', 'user'),
                        body: json.encode({
                          'userid': widget.userid.toString(),
                        }))
                    .then((value) async {
                  print('send successfully');
                  var response =
                      await http.get(Uri.http('127.0.0.1:5000', 'user1'));
                  List<dynamic> data = json.decode(response.body)['userid'];

                  List<dynamic> data1 = json.decode(response.body)['userid2'];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Showdata(data: data, data1: data1)));
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: HoverWidget(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    height: 50,
                    width: size.width / 6,
                    child: Center(
                      child: Text('Recommend Movies',
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
                    width: size.width / 6,
                    child: Center(
                      child: Text('Recommend Movies',
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
              height: 20,
            ),
          ],
        )));
  }
}
