import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quoteCard.dart';

class RandomQuoteScreen extends StatefulWidget {
  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {

  String quote = "";
  String author = "";

  Future<void> fetchQuote() async {

    final response =
    await http.get(Uri.parse("https://zenquotes.io/api/random"));

    final data = json.decode(response.body)[0];

    setState(() {
      quote = data['q'];
      author = data['a'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(

      onRefresh: fetchQuote,

      child: ListView(

        padding: EdgeInsets.all(20),

        children: [

          SizedBox(height: 60),

          Center(

            child: AnimatedSwitcher(

              duration: Duration(milliseconds: 500),

              child: quote.isEmpty
                  ? CircularProgressIndicator()

                  : QuoteCard(
                quote: quote,
                author: author,
              ),
            ),
          ),

          SizedBox(height: 40),

          Center(

            child: ElevatedButton.icon(

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14),
              ),

              onPressed: fetchQuote,

              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),

              label: Text(
                "New Quote",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}