import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebaseproject/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user?.photoURL ?? ''),
        ),
        Text('Email: ${user?.email ?? 'N/A'}'),
        Text('Phone Number: ${user?.phoneNumber ?? 'N/A'}'),
        Text('Display Name: ${user?.displayName ?? 'N/A'}'),
        Text('User UID: ${user?.uid ?? 'N/A'}'),
      ],
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userUid(),
              _signOutButton(),
            ],
          )),
    );
  }
}
