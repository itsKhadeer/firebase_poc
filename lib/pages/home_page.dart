import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebaseproject/auth.dart';
import 'package:flutterfirebaseproject/service/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomePage();
}

class HomePage extends State<Home> {
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

  Widget _create_post_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/write_article');
      },
      child: const Text('Create Post'),
    );
  }

  Widget _read_post_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/read_article');
      },
      child: const Text('Read Post'),
    );
  }

  Widget _view_all_users_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/view_all_users');
      },
      child: const Text('View All Users'),
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
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _create_post_button(context),
                _read_post_button(context),
                _view_all_users_button(context),
              ],
            ),
          )),
    );
  }
}
