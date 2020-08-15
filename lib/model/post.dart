import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String op;
  final int likes;
  final String opId;
  final Timestamp timestamp;

  Post({
    this.title,
    this.op,
    this.likes,
    this.opId,
    this.timestamp
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      title: doc['title'],
      op: doc['op'],
      likes: doc['likes'],
      opId: doc['opId'],
      timestamp: doc['timestamp'],
    );
  }
}