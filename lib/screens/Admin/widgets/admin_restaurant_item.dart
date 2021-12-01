import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRestaurantItem extends StatefulWidget {
  final String id;
  final String name;
  final String location;
  final String image;
  final List items;
  AdminRestaurantItem(
      {Key? key,
      required this.id,
      required this.name,
      required this.location,
      required this.image,
      required this.items})
      : super(key: key);

  @override
  _AdminRestaurantItemState createState() => _AdminRestaurantItemState();
}

class _AdminRestaurantItemState extends State<AdminRestaurantItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
        child: Row(
      children: [
        Expanded(
            child: Container(
          width: width / 2,
          height: width / 2,
          child: this.widget.image.isNotEmpty
              ? Image.network(
                  this.widget.image,
                  width: width / 2,
                  height: width / 2,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.white,
                  width: width / 2,
                  height: width / 2,
                  child: Image.asset('assets/image.png')),
        )),
        Expanded(
            child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                this.widget.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.orange),
              ),
              Text(this.widget.location,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 30),
              Row(
                children: [
                  isLoading
                      ? CircularProgressIndicator()
                      : TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestore.instance
                                .collection('restaurants')
                                .doc(this.widget.id)
                                .update({'isAccepted': true});
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Aceptar",
                            style: TextStyle(color: Colors.white),
                          )),
                ],
              )
            ],
          ),
        )),
      ],
    ));
  }
}
