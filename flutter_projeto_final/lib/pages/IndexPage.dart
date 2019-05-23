import 'package:flutter/material.dart';
import 'package:flutter_projeto_final/pages/MoviesPage.dart';

class IndexPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movies"),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: "All",
              icon: Icon(Icons.local_movies),
            ),
            Tab(
              text: "Favorites",
              icon: Icon(Icons.favorite),
            )
          ],),
        ),
        body: TabBarView(children: [
          MoviesPage(false),
          MoviesPage(true)
        ])
      ),
    )
    ;
  }
}