import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  List<String> favorites = [];

  Future<void> loadFavorites() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Favorite Quotes"),
      ),

      body: favorites.isEmpty
          ? Center(
        child: Text(
          "No favorites yet ❤️",
          style: TextStyle(fontSize: 18),
        ),
      )

          : ListView.builder(
        padding: EdgeInsets.all(16),

        itemCount: favorites.length,

        itemBuilder: (context, index) {

          return Card(

            elevation: 4,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: EdgeInsets.all(18),

              child: Text(
                favorites[index],
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}