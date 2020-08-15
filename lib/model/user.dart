import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String username;
  final String college;

  User({
    this.id,
    this.name,
    this.username,
    this.college
  });

  factory User.fromDoc(DocumentSnapshot doc){
    return User(
      id: doc.documentID,
      name: doc['name'],
      username: doc['username'],
      college: doc['college']
    );
  }
}