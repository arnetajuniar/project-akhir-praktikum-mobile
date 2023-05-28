import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:project_tpm/view/page_login.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscured = true;

  final _conUsername = TextEditingController();
  final _conPassword = TextEditingController();

  Future<void> _register() async {
    final username = _conUsername.text.trim();
    final password = _conPassword.text.trim();

    if (username.isEmpty) {
      _showSnackbar('Username cannot be empty');
      return;
    }

    if (password.isEmpty) {
      _showSnackbar('Password cannot be empty');
      return;
    }

    final loginBox = Hive.box('loginBox');
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    if (loginBox.containsKey(username)) {
      //mengecek apakah didalam kotak sudah terdapat username tersebut atau belum
      _showSnackbar('Username already exists');
    } else {
      loginBox.put(username,
          hashedPassword); //jika belum, username dan password akan tersimpan
      _showSnackbar('Registration Successful');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Register Page"),
              backgroundColor: Colors.teal,
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(60),
                  child: const Text(
                    "Create Your Account First!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 100, top: 16, right: 100),
                        child: Column(children: [
                          TextFormField(
                            controller: _conUsername,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Username',
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.tealAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _conPassword,
                            obscureText: isPasswordObscured,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              labelText: 'Password',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.tealAccent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(isPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isPasswordObscured = !isPasswordObscured;
                                  });
                                },
                              ),
                            ),
                          ),
                        ]))),
                Container(
                  padding:
                      const EdgeInsets.only(left: 100, top: 16, right: 100),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Does you have account? ',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Colors.teal,
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            //navigasi ke halaman lain dan menghapus semua halaman yang ada di dalam tumpukan navigasi
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PageLogin()),
                            (Route<dynamic> route) => false);
                      },
                    )
                  ],
                ),
              ],
            )));
  }
}
