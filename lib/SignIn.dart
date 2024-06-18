// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  void _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      context.go('/');
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  void _signUpWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = _auth.currentUser;
      final uid = user?.uid;
      await _firestore
          .collection('users')
          .doc(uid)
          .set({'ids': []}, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Fakeflix',
            style: TextStyle(
              color: Color.fromRGBO(178, 7, 16, 1),
              fontFamily: 'BebasNeue',
              fontSize: 40,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Sign In ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                const Text('or',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                const Text('Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white)),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _signInWithEmailAndPassword,
                        child: const Text('Sign In'),
                      ),
                      const Text('or',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      ElevatedButton(
                        onPressed: _signUpWithEmailAndPassword,
                        child: const Text('Sign Up'),
                      ),
                    ])
              ],
            ),
          ),
        ]));
  }
}
