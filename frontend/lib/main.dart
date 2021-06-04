import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/loginpage.dart';
import 'package:frontend/movieRecommendation/movierecom.dart';
import 'package:frontend/premierRecomm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboard(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () async {
              var response = await http.get(Uri.http('127.0.0.1:5000', ''));
              List<dynamic> data = json.decode(response.body)['name'];
              FirebaseFirestore.instance
                  .collection('movie')
                  .add({'moviename': 'predestination'});
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieRecom(
                            data: data,
                          )));
            },
            child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amber),
                child: Center(
                    child: Text(
                  'datam',
                ))),
          ),
        ),
      ),
    );
  }
}

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  void initState() {
    setState(() {
      future();
    });
    super.initState();
  }

  Future<List<dynamic>> future() async {
    var response = await http.get(Uri.http('127.0.0.1:5000', ''));
    List<dynamic> data = json.decode(response.body)['name'];
    List<dynamic> item = [];
    String a;
    /*for (var i = 0; i < data.length; i++) {
      setState(() {
        a = data[i].join(" ");
        item.add(a);
      });
    }*/
    print(data);
    return data;
  }

  @override
  void dispose() {
    setState(() {
      future();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Text('Movies with high ratings from user based',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.amber))),
        Container(
            height: 800,
            width: size.width / 4,
            color: Colors.grey.shade100,
            child: FutureBuilder(
              builder: (BuildContext con, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemBuilder: (context, int index) {
                        return Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://th.bing.com/th/id/R405258d55be4145c89fec68d095c9463?rik=IIHl7o5gb%2fWuXQ&riu=http%3a%2f%2f3.bp.blogspot.com%2f_Fv90J7eTcis%2fTJsHSkEnFrI%2fAAAAAAAAHSs%2fgKAetPAW9UY%2fs1600%2fM-Net%2bMovies%2b1%2bHD%2bnight%2btime%2blook%2blogo.jpg&ehk=F2GICmmtLVK7rJYX1ggsQmA5mRPV7%2beSnejxss2Cpx0%3d&risl=&pid=ImgRaw',
                                        height: 60,
                                        width: size.width / 8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        height: 50,
                                        width: size.width / 5,
                                        child: Text(
                                            snap.data[index][0].toString())),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        height: 50,
                                        width: size.width / 5,
                                        child: Text(
                                            snap.data[index][1].toString())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snap.data.length,
                    ),
                  );
                } else if (snap.hasError) {
                  return Text('${snap.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
              future: future(),
            )),
      ]),
    );
  }
}
/*
class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  Future<void> future() async {
    var response = await http.get('http://127.0.0.1:5000/');
    Map<String,List> data = json.decode(response.body)['name'];

    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Center(
        child: FutureBuilder(
            future: future(),
            builder: (con, snap) {
              switch (snap.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.waiting:
                  return Text('waiting..');
                case ConnectionState.done:
                  return Container(
                    child: ListView.builder(
                      itemBuilder: (context, int index) {
                        List list = snap.data;
                        String a = list.join(',');
                        print('after split' + a);
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                height: 60,
                                width: 200,
                                color: Colors.amber,
                                child: Center())
                          ],
                        );
                      },
                      itemCount: snap.data.length,
                    ),
                  );

                case ConnectionState.active:

                default:
                  return Text('default');
              }
            }),
      ),
    )));
  }
}

class Works extends StatefulWidget {
  @override
  _WorksState createState() => _WorksState();
}

class _WorksState extends State<Works> {
  Future<String> futureresponse() async {
    var response = await http.get('http://127.0.0.1:5000/data1');
    Map<String, List> list = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Center(
        child: FutureBuilder(
            future: futureresponse(),
            builder: (con, snap) {
              switch (snap.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.waiting:
                  return Text('waiting..');
                case ConnectionState.done:
                  return Container(
                    child: Center(
                      child: Column(
                          children: snap.data['name'].map((e) {
                        return Text(e);
                      })),
                    ),
                  );
                case ConnectionState.active:

                default:
                  return Text('default');
              }
            }),
      ),
    )));
  }
}
*/
