import 'package:flutter/material.dart';
import 'package:project_tpm/view/page_detail_books.dart';
import 'package:provider/provider.dart';
import '../model/books_list.dart';

class FavoritePageModel extends ChangeNotifier {
  List<Books> _favoriteList = [];

  List<Books> get favoriteList => _favoriteList;

  set favoritelist(BookList favoritelist) {}

  void add(Books book) {
    book.isFavorite = true;
    _favoriteList.add(book);
    notifyListeners();
  }

  void remove(Books book) {
    book.isFavorite = false;
    _favoriteList.remove(book);
    notifyListeners();
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the FavoritePageModel using Provider
    var favoritePageModel = Provider.of<FavoritePageModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
      ),
      body: ListView.builder(
        itemCount: favoritePageModel.favoriteList.length,
        itemBuilder: (context, index) {
          var book = favoritePageModel.favoriteList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDetailBooks(id: book.id!),
                ),
              );
            },
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  book.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(book.title ?? ''),
              subtitle: Text(book.authors ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () {
                  favoritePageModel.remove(book);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
