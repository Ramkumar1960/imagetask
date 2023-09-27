import 'package:assignment/MyApp.dart';
import 'package:assignment/pictures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'allimage.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pageController = PageController(initialPage: 1);
  int currentSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text(''),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
              icon: Icon(Icons.add,))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('wallpapers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            var wallpapersList = List<Wallpaper>.empty(growable: true);

            snapshot.data?.docs.forEach((documentSnapshot) {
              var wallpaper = Wallpaper.fromDocumentSnapshot(documentSnapshot);
              wallpapersList.add(wallpaper);
            });

            return PageView.builder(
              controller: pageController,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return _getPagesAtIndex(index, wallpapersList);
              },
              onPageChanged: (int index) {
                setState(() {
                  currentSelected = index;
                });
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }


  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting, // Shifting
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(
          fontFamily: 'VujahdayScript-Regular'
      ),
      currentIndex: currentSelected,
      backgroundColor: Colors.green,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'All Images',
          backgroundColor: Colors.green,),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
          backgroundColor: Colors.green,),
      ],
      onTap: (int index) {
        setState(() {
          currentSelected = index;
          pageController.animateToPage(
            currentSelected,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
          );
        });
      },
    );
  }

  Widget _getPagesAtIndex(int index, List<Wallpaper> wallpaperList) {
    switch (index) {
      case 0:
        return Home(
          wallpapersList: wallpaperList,
        );
      case 1:
        return MyHomePage();
      default:
        return const CircularProgressIndicator();
    }
  }
}

