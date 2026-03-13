import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'quoteCard.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class WallpaperGenerator extends StatefulWidget {
  final String quote;
  final String author;

  WallpaperGenerator({required this.quote, required this.author});

  @override
  State<WallpaperGenerator> createState() => _WallpaperGeneratorState();
}

class _WallpaperGeneratorState extends State<WallpaperGenerator> {
  ScreenshotController screenshotController = ScreenshotController();

  // ---------------- Save wallpaper to gallery ----------------
  void saveWallpaper() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/quote_wallpaper.png');
      await file.writeAsBytes(image);

      await GallerySaver.saveImage(file.path, albumName: "QuotesApp");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Wallpaper saved to gallery")),
      );
    }
  }

  // ---------------- Share wallpaper ----------------
  void shareWallpaper() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/quote_wallpaper.png');
      await file.writeAsBytes(image);

      // Share using share_plus
      await Share.shareXFiles(
        [XFile(file.path)],
        text: "Check out this motivational quote!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate Wallpaper")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade100, Colors.green.shade100],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: QuoteCard(
                  quote: widget.quote,
                  author: widget.author,
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: saveWallpaper,
                  icon: Icon(Icons.download),
                  label: Text("Save"),
                ),
                ElevatedButton.icon(
                  onPressed: shareWallpaper,
                  icon: Icon(Icons.share),
                  label: Text("Share"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}