import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfirebaseproject/auth.dart';
import 'package:flutterfirebaseproject/service/database.dart';

class WriteArticle extends StatefulWidget {
  const WriteArticle({super.key});
  @override
  State<WriteArticle> createState() => WriteArticlePage();
}

class WriteArticlePage extends State<WriteArticle> {
  final User? user = Auth().currentUser;

  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
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

  Widget allArticleDetails() {
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
            TextField(
              controller: titleController,
              
              style: const TextStyle(
                color: Colors.blue,
              
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            
              decoration:  InputDecoration(
                labelText: 'Title',
              
                labelStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                  gapPadding: 20.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: TextField(
                controller: contentController,
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  DatabaseMethods().addArticle(
                    content,
                    title,
                  );
                  titleController.clear();
                  contentController.clear();
                }
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
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
