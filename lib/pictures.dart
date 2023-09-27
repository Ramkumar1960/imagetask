
import 'package:cloud_firestore/cloud_firestore.dart';

class Wallpaper {
  final String url;
  final String desc;
  final String title;
  final String id;

  Wallpaper({
    required this.url,
    required this.desc,
    required this.title,
    required this.id,
  });

  factory Wallpaper.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Wallpaper(
      url: snapshot.get('url'),
      desc: snapshot.get('desc'),
      title: snapshot.get('title'),
      id: snapshot.id,
    );
  }

}