import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikeCommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Like toggle karna
  Future<void> toggleLike(String quoteId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final docRef = _firestore.collection('quotes').doc(quoteId);

    final doc = await docRef.get();
    List likes = doc['likes'] ?? [];

    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }

    await docRef.update({'likes': likes});
  }

  // Comment add karna
  Future<void> addComment(String quoteId, String comment) async {
    final uid = _auth.currentUser?.uid;
    final displayName = _auth.currentUser?.displayName ?? 'Anonymous';

    if (uid == null) return;

    final docRef = _firestore.collection('quotes').doc(quoteId).collection('comments').doc();

    await docRef.set({
      'uid': uid,
      'author': displayName,
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Comments read karna
  Stream<QuerySnapshot> getComments(String quoteId) {
    return _firestore
        .collection('quotes')
        .doc(quoteId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}