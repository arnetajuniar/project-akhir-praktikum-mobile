import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_tpm/model/books_list.dart';
import 'package:project_tpm/view/favorite_page.dart';
import 'view/page_login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('loginBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => BookList()),
          ChangeNotifierProxyProvider<BookList, FavoritePageModel>(
              create: (context) => FavoritePageModel(),
              update: (context, favoritelist, favoritepage) {
                if (favoritepage == null)
                  throw ArgumentError.notNull('favoritepage');
                favoritepage.favoritelist = favoritelist;
                return favoritepage;
              })
        ],
        child: MaterialApp(
          title: 'dBooks Library',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: const PageLogin(),
        ));
  }
}
