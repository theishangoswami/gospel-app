import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gospel/model/post.dart';
import 'package:gospel/model/user.dart';
import 'package:gospel/util/constants.dart';

class DatabaseService{

  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }

  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'username': user.username,
      'college':user.college
    });
  }

  static void createPost(Post post) {
    postsRef.document(post.opId).collection('userPosts').add({
      'title': post.title,
      'op': post.op,
      'likes': post.likes,
      'opId': post.opId,
      'timestamp': post.timestamp,
    });
  }

  static Stream<List<Post>> getFeedPosts(String userId) {
    return feedsRef
        .document(userId)
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.documents.map((doc) => Post.fromDoc(doc)).toList());
  }
  
  static Future<List<Post>> getUserPosts(String userId) async {
    QuerySnapshot userPostsSnapshot = await postsRef
        .document(userId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        userPostsSnapshot.documents.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
  }

  // static void likePost({String currentUserId, Post post}) {
  //   DocumentReference postRef = postsRef
  //       .document(post.authorId)
  //       .collection('userPosts')
  //       .document(post.id);
  //   postRef.get().then((doc) {
  //     int likeCount = doc.data['likeCount'];
  //     postRef.updateData({'likeCount': likeCount + 1});
  //     likesRef
  //         .document(post.id)
  //         .collection('postLikes')
  //         .document(currentUserId)
  //         .setData({});
  //     // addActivityItem(currentUserId: currentUserId, post: post, comment: null);
  //   });
  // }

  // static void unlikePost({String currentUserId, Post post}) {
  //   DocumentReference postRef = postsRef
  //       .document(post.authorId)
  //       .collection('userPosts')
  //       .document(post.id);
  //   postRef.get().then((doc) {
  //     int likeCount = doc.data['likeCount'];
  //     postRef.updateData({'likeCount': likeCount - 1});
  //     likesRef
  //         .document(post.id)
  //         .collection('postLikes')
  //         .document(currentUserId)
  //         .get()
  //         .then((doc) {
  //       if (doc.exists) {
  //         doc.reference.delete();
  //       }
  //     });
  //   });
  // }

}