import 'package:flutter/material.dart';
import 'package:restaurants/screens/Restaurants/widgets/create_menu_item.dart';

class CreateMenu extends StatefulWidget {
  final List menu;
  const CreateMenu({Key? key, required this.menu}) : super(key: key);

  @override
  _CreateMenuState createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Tu menú"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CreateMenuItem(menu: widget.menu)));
        },
      ),
      body: widget.menu.length > 0
          ? SingleChildScrollView(
              child: Wrap(
                  children: widget.menu
                      .map((menu) => Card(
                            child: Column(
                              children: [
                                Container(
                                  width: width / 2.1,
                                  height: width / 2.1,
                                  child: Image.network(
                                    menu['image'],
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
                                    menu['name'],
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
                                    child: Text(menu['description'],
                                        maxLines: 2,
                                        textAlign: TextAlign.center)),
                                SizedBox(height: 10),
                              ],
                            ),
                          ))
                      .toList()))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty.png',
                    width: 250,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "No haz creado un menú",
                    style: TextStyle(color: Colors.grey[700], fontSize: 22),
                  )
                ],
              ),
            ),
    );
  }
}
