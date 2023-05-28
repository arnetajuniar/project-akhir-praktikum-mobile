import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tpm/view/page_list_books.dart';

class PageSearchBooks extends StatefulWidget {
  const PageSearchBooks({Key? key}) : super(key: key);

  @override
  State<PageSearchBooks> createState() => _PageSearchBooksState();
}

class _PageSearchBooksState extends State<PageSearchBooks> {
  final _controller = TextEditingController();
  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Books"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 15),
                  child: const Text("Welcome to dBooks Library",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: const Text("FREE DOWNLOAD OPEN BOOKS",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                TextField(
                  selectionHeightStyle: BoxHeightStyle.max,
                  style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(fontSize: 15)),
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
                    hintText: "Enter book title, ISBN or author",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    filled: true,
                    icon: const Icon(
                      Icons.search,
                      size: 40.0,
                    ),
                  ),
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PageListBooks(text: _controller.text);
              }));
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Empty Input'),
                  content:
                      const Text('Please enter a book title, ISBN, or author.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text("SEARCH", style: TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
