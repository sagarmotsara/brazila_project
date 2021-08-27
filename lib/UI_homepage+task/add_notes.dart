import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoproject_brazila/logic/databaseoperations.dart';

class AddNote extends StatefulWidget {
  final String ?titl;
  final String? description;
  final DocumentReference? docref;

  const AddNote(
      {Key? key,
       this.titl,
       this.description,
       this.docref})
      : super(key: key);
  @override
  _AddNoteState createState() =>
      _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String ?title;
  String ?des;
    
     @override
  void initState() {
     if(widget.titl!=null){
       title = widget.titl;
     }
     if(widget.description!=null){
       des = widget.description;
     }
    super.initState();
  }

  
  final _textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[300],
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),

                    //
                    ElevatedButton(
                      onPressed: add,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[300],
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.only(bottom: 20.0)),
                SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  key: _textKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (_val) {
                           
                          title = _val;
                        },
                        initialValue: widget.titl,
                        decoration: InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: TextStyle(
                          fontSize: 27.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      //
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          onChanged: (_val) {
                           
                            des = _val;
                          },
                          initialValue: widget.description,
                          decoration: InputDecoration(
                            hintText: "Description",
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20.0)),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: updatedata,
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "lato",
                        color: Colors.black,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey[300],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    Map<String, dynamic> mymap = {
      "title": title,
      "description": des,
      "date": DateTime.now()
    };
    var firebaseUser = FirebaseAuth.instance.currentUser!.uid;
    await Database.create(mymap, firebaseUser);

    Navigator.pop(context);
    setState(() {
      
    });
  }

  void updatedata() async {
    Map<String, dynamic> mymap = {
      "title": title,
      "description": des,
      "date": DateTime.now()
    };

      await widget.docref!.update(mymap);
       Navigator.of(context).pop();
    setState(() {
    });

    // String docid2 = collectionReference.doc().id;
    // await Database.update(docid2, mymap);
  }
}
