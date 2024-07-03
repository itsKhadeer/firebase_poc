import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebaseproject/auth.dart';

import 'data_models.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update collection names based on your actual structure
  final String _usersCollection = 'users';
  final String _topicsCollection = 'topics';
  final String _articlesCollection = 'articles';
  final String _commentsCollection = 'comments';
  final String _votesCollection = 'votes'; // Optional, if implementing voting

  // Add user details
  Future<void> addUserDetails(User user) async {
    final userData = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await _firestore.collection(_usersCollection).doc(user.uid).set(userData);
  }

Future<Map<String, dynamic>?> fetchUser(String uid) async {
  final snapshot = await _firestore.collection(_usersCollection).where('uid', isEqualTo: uid).get();

  if (snapshot.docs.isEmpty) {
    return null; // Handle case where user not found
  }

  final user = snapshot.docs.first.data() as Map<String, dynamic>;
  final userData = {
    'uid': user['uid'],
    'email': user['email'],
    'displayName': user['displayName'],
    'photoURL': user['photoURL'],
    'createdAt': user['createdAt'],
  };
  return userData;
}
  // Get all users stream
  Future<Stream<QuerySnapshot>> getUsers() async {
    return _firestore.collection(_usersCollection).snapshots();
  }

  // Add topic
  Future<void> addTopic(Topic topic) async {
    final topicData = topic.toMap();
    await _firestore.collection(_topicsCollection).doc(topic.id).set(topicData);
  }

  // Get all topics stream
  Future<Stream<QuerySnapshot>> getTopics() async {
    return _firestore.collection(_topicsCollection).snapshots();
  }

  // Add article
  Future<void> addArticle(String content, String title) async {
    final articleData = Article(
      id: "id",
      topicId: "topicId",
      writerId: Auth().currentUser!.uid,
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ).toMap();
    await _firestore.collection(_articlesCollection).doc().set(articleData);
  }

  // Get all articles stream
  Future<Stream<QuerySnapshot>> getArticles() async {
    return _firestore.collection(_articlesCollection).orderBy('updatedAt', descending: true).snapshots();
  }

  // Add comment
  Future<void> addComment(Comment comment) async {
    final commentData = comment.toMap();
    await _firestore
        .collection(_commentsCollection)
        .doc(comment.id)
        .set(commentData);
  }

  // Get all comments stream
  Future<Stream<QuerySnapshot>> getComments() async {
    return _firestore.collection(_commentsCollection).snapshots();
  }

  // Optional: Add vote
  Future<void> addVote(Vote vote) async {
    final voteData = vote.toMap();
    await _firestore.collection(_votesCollection).doc(vote.id).set(voteData);
  }

  // Optional: Get all votes stream
  Future<Stream<QuerySnapshot>> getVotes() async {
    return _firestore.collection(_votesCollection).snapshots();
  }
}
/*

Stream? EmployeeStream;

Widget allEmployeeDetails() {
  return StreamBuilder(
    stream: EmployeeStream,
    builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return EmployeeTile(
                  name: snapshot.data.docs[index].data()["name"],
                  email: snapshot.data.docs[index].data()["email"],
                  phone: snapshot.data.docs[index].data()["phone"],
                  id: snapshot.data.docs[index].data()["id"],
                );
              },
            )
          : Container();
    },

}



 */

// method to call this function

//  await DatabaseMethods().addEmployeeDetails(employeeInfoMap, id)
//    .then((value) {
//      Fluttertoast.showToast(msg: "Employee added successfully");
//    }
//  );



 