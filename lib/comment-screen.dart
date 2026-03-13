import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'like_comment_service.dart';

class CommentsScreen extends StatefulWidget {
  final String quoteId;

  CommentsScreen({required this.quoteId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();
  final LikeCommentService _service = LikeCommentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _service.getComments(widget.quoteId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final comments = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final data = comments[index];
                    return ListTile(
                      title: Text(data['author']),
                      subtitle: Text(data['comment']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Add a comment"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;
                    _service.addComment(widget.quoteId, _controller.text.trim());
                    _controller.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}