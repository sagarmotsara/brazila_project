import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoproject_brazila/UI_homepage+task/add_notes.dart';

class updatePage extends StatefulWidget {
  String? title;
  String? description;
  String? datetimenow;
  DocumentReference? docref;
  updatePage(
      {Key? key,
      required this.title,
      required this.description,
      required this.datetimenow,
      required this.docref})
      : super(key: key);

  @override
  _updatePageState createState() => _updatePageState();
}

class _updatePageState extends State<updatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(bottom: 45.0)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300]),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      )),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 50.0)),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.black,
                      width: 0.1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.title!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.deepPurple),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Text(
                              widget.description!,
                              style: TextStyle(color: Colors.deepPurple),
                            )),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        color: Colors.grey[200],
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 10.0)),
                            Text(
                              widget.datetimenow!,
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.grey[600]),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.5)),
                            Icon(
                              Icons.image,
                              color: Colors.grey[600],
                            ),
                            Icon(
                              Icons.mic,
                              color: Colors.grey[600],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.grey[200], border: Border(bottom: BorderSide.none)),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AddNote(
                              titl: widget.title,
                              description: widget.description,
                              docref: widget.docref,
                            )));
                  },
                  icon: Icon(
                    Icons.border_color,
                    color: Colors.deepPurple,
                    size: 30.0,
                  )),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.star, color: Colors.yellow[800], size: 30.0),
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.share_outlined,
                      color: Colors.deepPurple, size: 30.0)),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.more_vert,
                      color: Colors.deepPurple, size: 30.0))
            ],
          ),
        ));
  }
}
