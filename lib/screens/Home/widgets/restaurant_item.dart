import 'package:flutter/material.dart';
import 'package:restaurants/screens/Home/widgets/restaurant_item_menu.dart';

class RestaurantItem extends StatelessWidget {
  final String name;
  final String location;
  final String image;
  final List items;
  RestaurantItem(
      {Key? key,
      required this.name,
      required this.location,
      required this.image,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    RestaurantItemMenu(items: this.items, name: this.name)));
      },
      child: Card(
          child: Row(
        children: [
          Expanded(
              child: Container(
            width: width / 2,
            height: width / 2,
            child: this.image.isNotEmpty
                ? Image.network(
                    this.image,
                    width: width / 2,
                    height: width / 2,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
                    width: width / 2,
                    height: width / 2,
                    child: Center(
                      child: Text("Sin foto"),
                    ),
                  ),
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  this.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.orange),
                ),
                Text(this.location,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          )),
        ],
      )),
    );
  }
}
