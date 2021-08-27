import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoproject_brazila/UI_homepage+task/add_notes.dart';

import 'package:todoproject_brazila/UI_homepage+task/update_read.dart';
import 'package:intl/intl.dart';
import 'package:todoproject_brazila/UI_of_email_registration/Login%20Screen.dart';
import 'package:todoproject_brazila/UI_of_email_registration/landing%20screen.dart';

import 'package:todoproject_brazila/logic/databaseoperations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final FirebaseAuth auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var firebaseUser = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference? docref;
  _signOut() async {
    await widget.auth.signOut();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LandingScreen()));
        setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            // making appbar using row;
            Padding(padding: EdgeInsets.all(25.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25.0),
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("LogOut"),
                        value: 1,
                      ),
                    ],
                    icon: Icon(Icons.menu),
                    onSelected: (value) async {
                      if (value == 1) {
                        await _signOut();
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                ),
                Text("MyNotes",
                    style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.only(right: 25.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      color: Colors.indigo[900]),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 1.0)),

            Flexible(
              child: FutureBuilder<QuerySnapshot>(
                future: Database.read(firebaseUser),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<dynamic, dynamic>? data =
                            snapshot.data!.docs[index].data() as Map?;
                        String time = DateFormat.yMMMd()
                            .add_jm()
                            .format(data!['date'].toDate());

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => updatePage(
                                title: data['title'],
                                description: data['description'],
                                datetimenow: time,
                                docref: snapshot.data!.docs[index].reference,
                              ),
                            ));
                          },
                          child: Container(
                            height: 135,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.5)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            "${data['title']}",
                                            style: TextStyle(
                                              color: Colors.indigo[900],
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[800],
                                          ),
                                          PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text("Delete"),
                                                value: 1,
                                              ),
                                            ],
                                            onSelected: (value) async {
                                              if (value == 1) {
                                                await snapshot.data!.docs[index]
                                                    .reference!
                                                    .delete();
                                                setState(() {});
                                              }
                                            },
                                            icon: Icon(
                                              Icons.more_vert_outlined,
                                              color: Colors.indigo[900],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          "${data['description']}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.0,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                      // Text(
                                      //   '${DateFormat.yMMMd().add_jm().format(datetimesaved)}',
                                      //   style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                      // ),
                                      Text(
                                        time,
                                        style: TextStyle(
                                            fontSize: 10.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple,
        ));
  }
}
