import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllQuotesScreen extends StatefulWidget {
  @override
  _AllQuotesScreenState createState() => _AllQuotesScreenState();
}

class _AllQuotesScreenState extends State<AllQuotesScreen> {

  List quotes = [];

  Future<void> fetchAllQuotes() async {

    final response =
    await http.get(Uri.parse('https://zenquotes.io/api/quotes'));

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      setState(() {
        quotes = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllQuotes();
  }

  @override
  Widget build(BuildContext context) {

    if (quotes.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(

      padding: EdgeInsets.all(16),

      itemCount: quotes.length,

      itemBuilder: (context, index) {

        return Container(

          margin: EdgeInsets.only(bottom: 15),

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(18),

            gradient: LinearGradient(
              colors: [
                Color(0xffECFDF5),
                Colors.white
              ],
            ),

            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black12,
                offset: Offset(0,4),
              )
            ],
          ),

          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: Color(0xff16A34A),
              child: Icon(Icons.format_quote,
                  color: Colors.white),
            ),

            title: Text(
              quotes[index]['q'],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),

            subtitle: Padding(
              padding: EdgeInsets.only(top:6),
              child: Text(
                "- ${quotes[index]['a']}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}