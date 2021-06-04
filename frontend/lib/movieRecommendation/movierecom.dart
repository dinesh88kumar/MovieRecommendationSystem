import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MovieRecom extends StatefulWidget {
  List<dynamic> data;
  MovieRecom({required this.data});

  @override
  _MovieRecomState createState() => _MovieRecomState();
}

class _MovieRecomState extends State<MovieRecom> {
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              'Movies with high ratings from user based',
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800),
            )),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 900,
              width: size.width / 1,
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 100),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,
                      width: size.width / 5,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: size.width / 5,
                            color: Colors.red,
                            child: Image.network(
                              'https://th.bing.com/th/id/R405258d55be4145c89fec68d095c9463?rik=IIHl7o5gb%2fWuXQ&riu=http%3a%2f%2f3.bp.blogspot.com%2f_Fv90J7eTcis%2fTJsHSkEnFrI%2fAAAAAAAAHSs%2fgKAetPAW9UY%2fs1600%2fM-Net%2bMovies%2b1%2bHD%2bnight%2btime%2blook%2blogo.jpg&ehk=F2GICmmtLVK7rJYX1ggsQmA5mRPV7%2beSnejxss2Cpx0%3d&risl=&pid=ImgRaw',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 150,
                            width: size.width / 5,
                            color: Colors.amber,
                            child: Column(
                              children: [
                                Text(widget.data[index][0]),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(widget.data[index][1]),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
