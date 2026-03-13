import 'package:flutter/material.dart';
import 'favouriteQuoteScreen.dart';
import 'randomQuoteScreen.dart';
import 'todayQuoteScreen.dart';
import 'allQuoteScreen.dart';
import 'searchQuoteScreen.dart';

class QuoteHomeScreen extends StatelessWidget {

  final Function toggleTheme;
  final bool isDark;

  QuoteHomeScreen({required this.toggleTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,

      child: Scaffold(

        appBar: AppBar(
          title: Text(
            "Daily Quotes",
            style: TextStyle(color: Colors.white),
          ),

          iconTheme: IconThemeData(color: Colors.white),

          actions: [

            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchQuoteScreen(),
                  ),
                );
              },
            ),

            IconButton(
              icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode
              ),
              onPressed: () => toggleTheme(),
            ),

            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(),
                  ),
                );
              },
            ),
          ],

          bottom: TabBar(

            indicatorColor: Colors.orange,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,

            tabs: [

              Tab(
                icon: Icon(Icons.auto_awesome),
                text: "Random",
              ),

              Tab(
                icon: Icon(Icons.grid_view),
                text: "All",
              ),

              Tab(
                icon: Icon(Icons.wb_sunny),
                text: "Today",
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            RandomQuoteScreen(),
            AllQuotesScreen(),
            TodayQuoteScreen(),
          ],
        ),
      ),
    );
  }
}