import 'package:flutter/material.dart';
import 'offline_quotes.dart';
import 'quoteCard.dart';
import 'wallpaperGenerator.dart';

class CategoriesScreen extends StatelessWidget {
  final String category;

  CategoriesScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final filtered = OfflineQuotes.quotes
        .where((q) => q['c']?.toLowerCase() == category.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("$category Quotes")),
      body: filtered.isEmpty
          ? Center(child: Text("No quotes found in this category"))
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final quote = filtered[index]['q'] ?? '';
          final author = filtered[index]['a'] ?? '';
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                QuoteCard(
                  quote: quote,
                  author: author,
                ),
                SizedBox(height: 5),
                ElevatedButton.icon(
                  icon: Icon(Icons.wallpaper),
                  label: Text("Generate Wallpaper"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WallpaperGenerator(
                          quote: quote,
                          author: author,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}