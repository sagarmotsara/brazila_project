import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final firebaseUser = FirebaseAuth.instance.currentUser;
final collectionReference = _firestore
    .collection("products")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('user');

class Database {
  static create(Map<String, dynamic> data, String uid) {
    collectionReference.add(data);
  }

  static update(String docId, Map<String, dynamic> data) async {
    collectionReference.doc(docId).update(data);
  }

//   //return future (so we can use FutureBuilder() widget to display content)
  static Future<QuerySnapshot> read(String uid) async {
    final QuerySnapshot querySnapshot = await collectionReference.get();
    return querySnapshot;
  }

  //return stream of data so we can use StreamBuilder() widget to display data
  // static Stream<QuerySnapshot> read2() {
  //   final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('products').snapshots();
  //   return _userStream;
  // }

//   static delete(String docId) {
//     collectionReference.doc(docId).delete();
//   }
}
