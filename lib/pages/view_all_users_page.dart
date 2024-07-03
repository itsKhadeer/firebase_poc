import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebaseproject/auth.dart';
import 'package:flutterfirebaseproject/service/database.dart';

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({super.key});
  @override
  State<ViewAllUsers> createState() => ViewAllUsersPage();
}

class ViewAllUsersPage extends State<ViewAllUsers> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('All users');
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

  Stream? UserStream;
  getontheload() async {
    UserStream = await DatabaseMethods().getUsers();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allUserDetails() {
    return StreamBuilder(
      stream: UserStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Material(
                    elevation: 5.0,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (ds['photoURL'] != '' && ds['photoURL'] != null)
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(ds['photoURL']),
                                )
                              : const Text("user image not available"),
                          Text(
                            "Name: ${ds['displayName']}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Age: ${ds['email']}",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Location : ${ds['createdAt']}",
                            style: const TextStyle(
                              color: Colors.blue,
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
              Expanded(child: allUserDetails()),
            ],
          )),
    );
  }
}
