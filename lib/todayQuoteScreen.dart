import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodayQuoteScreen extends StatefulWidget {
  @override
  _TodayQuoteScreenState createState() => _TodayQuoteScreenState();
}

class _TodayQuoteScreenState extends State<TodayQuoteScreen> {
  String todayQuote = '';
  String todayAuthor = '';

  Future<void> fetchTodayQuote() async {
    final response =
    await http.get(Uri.parse('https://zenquotes.io/api/today'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)[0];

      setState(() {
        todayQuote = data['q'];
        todayAuthor = data['a'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTodayQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffEEF2FF),
            Color(0xffFFFFFF)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: todayQuote.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 3,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(Icons.format_quote,
                    size: 40,
                    color: Color(0xff4F46E5)),

                SizedBox(height: 15),

                Text(
                  '"$todayQuote"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "- $todayAuthor",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}