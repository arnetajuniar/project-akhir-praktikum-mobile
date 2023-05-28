import 'package:flutter/material.dart';
import 'package:project_tpm/view/page_login.dart';
import 'package:project_tpm/view/page_search_books.dart';

import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HalamanUtama(),
    ProfilePage(),
    PageLogin(),
  ];

  void _onItemTapped(int index) {
    if (index == _pages.length - 1) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const PageLogin()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey[900],
        onTap: _onItemTapped,
      ),
    ));
  }
}

class HalamanUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const PageSearchBooks();
                    }),
                  );
                },
                splashColor: Colors.teal,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.menu_book, size: 70, color: Colors.teal),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        "Search Books",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FavoritePage();
                    }),
                  );
                },
                splashColor: Colors.teal,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.favorite, size: 70, color: Colors.teal),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        "Favorites Book",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final List<ProfileData> profiles = [
    ProfileData(
      imagePath: 'assets/img/foto_arneta.jpg',
      name: 'Arneta Juniar Setiawan',
      studentId: '123200108',
      department: 'IF - C',
    ),
    ProfileData(
      imagePath: 'assets/img/foto_andita.jpeg',
      name: 'Andita Ayu Safitri',
      studentId: '123200118',
      department: 'IF - C',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal,
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return buildProfileCard(profiles[index]);
          },
        ),
      ),
    );
  }

  Widget buildProfileCard(ProfileData profile) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: AssetImage(profile.imagePath),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              profile.studentId,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              profile.department,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileData {
  final String imagePath;
  final String name;
  final String studentId;
  final String department;

  ProfileData({
    required this.imagePath,
    required this.name,
    required this.studentId,
    required this.department,
  });
}
