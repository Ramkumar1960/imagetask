import 'package:assignment/pictures.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<Wallpaper> wallpapersList;

  const Home({Key? key, required this.wallpapersList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final categories = List<String>.empty(growable: true);
  final categoryImages = List<String>.empty(growable: true);
  final desc = List<String>.empty(growable: true);
  @override
  void initState() {
    super.initState();

    widget.wallpapersList.forEach(
          (wallpaper) {
        var category = wallpaper.title;

        if (!categories.contains(category)) {
          categories.add(category);
          categoryImages.add(wallpaper.url);
          desc.add(wallpaper.desc);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categoryImages.length,
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          child: Column(
            children: [
              Text(categories.elementAt(index),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              Container(
                       decoration: BoxDecoration(
                       color: Colors.white, // Background color of the frame
                       border: Border.all(
                       color: Colors.black, // Color of the frame border
                       width: 4, // Width of the frame border
                        ),
                       borderRadius: BorderRadius.circular(12),
                       ),
                  width: 200,
                  child: Image.network(categoryImages.elementAt(index),
                  ),
              ),
              SizedBox(height: 10,),
              Text(desc.elementAt(index),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
            ],
          ),
        );
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1
    ),
    );
  }
}
//column- title, container(image), description