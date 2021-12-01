import 'package:flutter/material.dart';
import 'package:restaurants/screens/Admin/widgets/admin_restaurant_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('restaurants')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (!doc['isAccepted']) restaurants.add(doc.data());
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
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text("Administrador"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: restaurants
                      .map((restaurant) => AdminRestaurantItem(
                            id: restaurant['id'],
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
