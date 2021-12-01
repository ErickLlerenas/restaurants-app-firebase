import 'package:flutter/material.dart';
import 'package:restaurants/screens/Home/widgets/restaurant_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurants/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('restaurants')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['isAccepted']) restaurants.add(doc.data());
      });
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Restaurantes"),
          backgroundColor: Colors.orange),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: restaurants
                      .map((restaurant) => RestaurantItem(
                            name: restaurant['name'],
                            location: restaurant['location'],
                            image: restaurant['menu'].length > 0
                                ? restaurant['menu'][0]['image']
                                : '',
                            items: restaurant['menu'],
                          ))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
