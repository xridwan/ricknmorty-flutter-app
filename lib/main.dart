import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorty/data/api/api_service.dart';
import 'package:ricknmorty/provider/character_provider.dart';
import 'package:ricknmorty/themes/app_theme.dart';
import 'package:ricknmorty/ui/character_detail_page.dart';
import 'package:ricknmorty/ui/character_list_page.dart';
import 'package:ricknmorty/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterProvider>(
      create: (context) => CharacterProvider(apiService: ApiService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick N Morty',
        theme: ThemeData(
          textTheme: myTextTheme,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Colors.blue,
              ),
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          CharacterListPage.routeName: (context) => const CharacterListPage(),
          CharacterDetailPage.routeName: (context) => CharacterDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as int),
        },
      ),
    );
  }
}
