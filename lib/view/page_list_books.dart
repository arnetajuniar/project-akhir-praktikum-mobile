import 'package:flutter/material.dart';
import 'package:project_tpm/view/page_detail_books.dart';
import '../controller/api_data_source.dart';
import '../model/books_list.dart';
import 'package:provider/provider.dart';
import 'favorite_page.dart';

class PageListBooks extends StatefulWidget {
  final String text;
  const PageListBooks({Key? key, required this.text}) : super(key: key);

  @override
  State<PageListBooks> createState() => _PageListBooksState();
}

class _PageListBooksState extends State<PageListBooks> {
  late List<Books> booksList;
  bool _isNotFound = false;

  @override
  void initState() {
    super.initState();
    booksList = [];
    _searchBooks();
  }

  void _searchBooks() async {
    try {
      var bookModel = await ApiDataSource.instance.loadListBook(widget.text);
      setState(() {
        var bookList = BookList.fromJson(bookModel);
        _isNotFound = bookList.books == null || bookList.books!.isEmpty;
        booksList = bookList.books ?? [];
      });
    } catch (error) {
      setState(() {
        _isNotFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book List"),
      ),
      body: _isNotFound ? _buildNotFoundSection() : _buildListBooksBody(),
    );
  }

  Widget _buildNotFoundSection() {
    return const Center(
      child: Text("No Books Found."),
    );
  }

  Widget _buildListBooksBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadListBook(widget.text),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          return _buildSuccessSection();
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection() {
    return ListView.builder(
      itemCount: booksList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildBookItem(index);
      },
    );
  }

  Widget _buildBookItem(int index) {
    Books book = booksList[index];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageDetailBooks(id: book.id!),
          ),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(book.image!),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(book.authors!),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            _AddButton(
              item: book,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Books item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritePageModel = Provider.of<FavoritePageModel>(context);
    var isFavorite = favoritePageModel.favoriteList.contains(item);

    return IconButton(
      icon: isFavorite
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border, color: Colors.black12),
      onPressed: () {
        if (isFavorite) {
          favoritePageModel.remove(item);
        } else {
          favoritePageModel.add(item);
        }
      },
    );
  }
}
