import 'package:flutter/material.dart';

class RestaurantItemMenu extends StatelessWidget {
  final List items;
  final String name;
  RestaurantItemMenu({Key? key, required this.items, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Menú: $name"),
          backgroundColor: Colors.orange),
      body: SingleChildScrollView(
          child: Wrap(
              children: items
                  .map((item) => Card(
                        child: Column(
                          children: [
                            Container(
                              width: width / 2.1,
                              height: width / 2.1,
                              child: Image.network(
                                item['image'],
                                width: width / 2.1,
                                height: width / 2.1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: width / 2.1),
                              child: Text(
                                item['name'],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                constraints:
                                    BoxConstraints(maxWidth: width / 2.1),
                                child: Text(item['description'],
                                    maxLines: 2, textAlign: TextAlign.center)),
                            SizedBox(height: 10),
                          ],
                        ),
                      ))
                  .toList())),
    );
  }
}
