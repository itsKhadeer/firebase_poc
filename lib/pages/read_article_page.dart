import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time/date_time.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebaseproject/auth.dart';
import 'package:flutterfirebaseproject/service/database.dart';

class ReadArticle extends StatefulWidget {
  const ReadArticle({super.key});
  @override
  State<ReadArticle> createState() => ReadArticlePage();
}

class ReadArticlePage extends State<ReadArticle> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: user?.providerData[0].providerId == 'google.com'
          ? Auth().signOutFromGoogle
          : signOut,
      child: Text(user?.providerData[0].providerId == 'google.com'
          ? "sign out from google"
          : "normal signout"),
    );
  }

  Widget _profileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: const Text('Profile'),
    );
  }

  @override
  void initState() {
    getArticleonload();
    super.initState();
  }

  Stream? ArticleStream;
  getArticleonload() async {
    ArticleStream = await DatabaseMethods().getArticles();
    setState(() {});
  }

  Widget getUserName(String writerId) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: DatabaseMethods()
          .fetchUser(writerId), // Replace userId with actual value
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              heightFactor: 5.0,
              child: CircularProgressIndicator(),
            );
          default:
            final userData = snapshot.data;
            if (userData != null) {
              // Display user data here
              return Text(
                "Author : ${userData['displayName']}",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ); // Example: display display name
            } else {
              return const Text(
                  'User not found'); // Handle user not found case (optional)
            }
        }
      },
    );
  }

  Widget allArticleDetails() {
    return StreamBuilder(
      stream: ArticleStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title: ${ds['title']}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            getUserName(ds['writerId']),
                            Text(
                              DateTime.parse(ds['updatedAt'])
                                  .format('hh:mm a, MMM dd, yyyy')
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                          Text(
                            "Description: ${ds['content']}",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text("no data available"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [
          _signOutButton(),
          _profileButton(context),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: allArticleDetails()),
            ],
          )),
    );
  }
}
