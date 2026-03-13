import 'package:flutter/material.dart';
import 'offline_quotes.dart';
import 'quoteCard.dart';

class SearchQuoteScreen extends StatefulWidget {
  @override
  State<SearchQuoteScreen> createState() => _SearchQuoteScreenState();
}

class _SearchQuoteScreenState extends State<SearchQuoteScreen> {

  List results = OfflineQuotes.quotes;

  void search(String value) {
    final filtered = OfflineQuotes.quotes.where((quote) {
      final text = quote['q']!.toLowerCase();
      final author = quote['a']!.toLowerCase();
      final category = quote['c']!.toLowerCase();

      return text.contains(value.toLowerCase()) ||
          author.contains(value.toLowerCase()) ||
          category.contains(value.toLowerCase());
    }).toList();

    setState(() {
      results = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Quotes")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search quote, author, or category",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(child: Text("No results found"))
                : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: QuoteCard(
                    quote: results[index]['q'],
                    author: results[index]['a'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}