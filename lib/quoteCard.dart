import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteCard extends StatefulWidget {

  final String quote;
  final String author;

  QuoteCard({required this.quote, required this.author});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {

  bool isFavorite = false;

  Future<void> toggleFavorite() async {

    final prefs = await SharedPreferences.getInstance();

    List<String> list = prefs.getStringList("favorites") ?? [];

    String quoteText = "${widget.quote} - ${widget.author}";

    if(list.contains(quoteText)){

      list.remove(quoteText);
      isFavorite = false;

    }else{

      list.add(quoteText);
      isFavorite = true;

    }

    await prefs.setStringList("favorites", list);

    setState(() {});
  }

  void copyQuote(BuildContext context) {

    Clipboard.setData(
        ClipboardData(text: "${widget.quote} - ${widget.author}")
    );

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quote Copied"))
    );
  }

  void shareQuote() {
    Share.share("${widget.quote} - ${widget.author}");
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 6,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: EdgeInsets.all(24),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [

            Icon(
              Icons.format_quote,
              size: 40,
              color: Color(0xff16A34A),
            ),

            SizedBox(height: 15),

            Text(
              '"${widget.quote}"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 12),

            Text(
              "- ${widget.author}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                IconButton(
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: toggleFavorite,
                ),

                IconButton(
                  icon: Icon(Icons.copy, color: Colors.green),
                  onPressed: () => copyQuote(context),
                ),

                IconButton(
                  icon: Icon(Icons.share, color: Colors.orange),
                  onPressed: shareQuote,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}