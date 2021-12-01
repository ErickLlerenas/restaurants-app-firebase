import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/providers/user/provider.dart';
import 'package:restaurants/screens/Restaurants/widgets/create_menu.dart';
import 'package:restaurants/screens/Restaurants/widgets/create_restaurant.dart';
import 'package:restaurants/widgets/my_drawer.dart';

class MyRestaurantsScreen extends StatefulWidget {
  const MyRestaurantsScreen({Key? key}) : super(key: key);

  @override
  _MyRestaurantsScreenState createState() => _MyRestaurantsScreenState();
}

class _MyRestaurantsScreenState extends State<MyRestaurantsScreen> {
  List restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(Provider.of<UserProvider>(context, listen: false).email)
        .get()
        .then((user) {
      if (user.exists) {
        restaurants.add(user.data());
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text("Mi restaurante"),
        ),
        drawer: MyDrawer(),
        floatingActionButton: isLoading
            ? null
            : restaurants.length == 0
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateRestaurant()));
                    },
                    backgroundColor: Colors.amber,
                  )
                : null,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : restaurants.length > 0
                ? Center(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            restaurants[0]['menu'].length > 0
                                ? Container(
                                    height: 150,
                                    margin: EdgeInsets.all(30.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(restaurants[0]
                                                ['menu'][0]['image']),
                                            fit: BoxFit.cover),
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle),
                                  )
                                : Container(
                                    height: 150,
                                    margin: EdgeInsets.all(30.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/image.png'),
                                            fit: BoxFit.contain),
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle),
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              restaurants[0]['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey[600],
                                  ),
                                  Text(
                                    restaurants[0]['location'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                            SizedBox(height: 50),
                            Container(
                              height: 75,
                              width: width,
                              color: Colors.grey[200],
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tipo:',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.orange[800],
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            restaurants[0]['type'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ]),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'RFC:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.orange[800],
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          restaurants[0]['RFC'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            restaurants[0]['isAccepted']
                                ? Container(
                                    height: 50,
                                    color: Colors.teal[200],
                                    child: Center(
                                        child: Text('Aceptado',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.teal[600]))),
                                  )
                                : Container(
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: Center(
                                        child: Text(
                                      'Sin aceptar',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[600]),
                                    )),
                                  ),
                            SizedBox(height: 20),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.amber)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CreateMenu(
                                              menu: restaurants[0]['menu'])));
                                },
                                child: Text("Ver menú",
                                    style: TextStyle(color: Colors.white)))
                          ],
                        )),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        Image.asset(
                          'assets/empty.png',
                          width: 250,
                        ),
                        SizedBox(height: 20),
                        Text("No haz creado tu restaurante")
                      ]))));
  }
}
