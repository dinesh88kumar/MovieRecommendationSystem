import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:js_util';

class Showdata extends StatefulWidget {
  List<dynamic> data;
  List<dynamic> data1;
  Showdata({required this.data, required this.data1});
  @override
  _ShowdataState createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  /* Future<String> returnfromfutre() async {
    var response = await http.get(Uri.http('127.0.0.1:5000', 'user1'));
    String data = json.decode(response.body)['userid'];
    print(data.toString());
    return data;
  }

  @override
  void initState() {
    setState(() {
      returnfromfutre();
    });
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      returnfromfutre();
    });
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://i.imgur.com/OMSRrRS.png'))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
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
                              child: Text('HOME',
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
                              child: Text('HOME',
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
                    height: 230,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    height: 80,
                    width: size.width / 2,
                    color: Colors.amber,
                    child: Center(
                      child: Text('USER BASED RECOMMENDATION',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child:
                    /*FutureBuilder(
                  future: returnfromfutre(),
                  builder: (BuildContext con, AsyncSnapshot snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      return Text(snap.data.toString());
                    } else if (snap.hasError) {
                      return Text('error comes');
                    } else {
                      return Text('nodata');
                    }
                  }),*/
                    Container(
              color: Colors.black,
              height: 1200,
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
                            color: Colors.greenAccent,
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
            )),
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    height: 80,
                    width: size.width / 2,
                    color: Colors.amber,
                    child: Center(
                      child: Text('MOVIE BASED RECOMMENDATION',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 1200,
              width: size.width / 1,
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 100),
                  itemCount: widget.data1.length,
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
                            color: Colors.greenAccent,
                            child: Column(
                              children: [
                                Text(widget.data1[index][0]),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(widget.data1[index][1]),
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
