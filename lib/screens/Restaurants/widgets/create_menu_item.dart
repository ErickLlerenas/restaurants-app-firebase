import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/providers/user/provider.dart';

class CreateMenuItem extends StatefulWidget {
  final List menu;
  const CreateMenuItem({Key? key, required this.menu}) : super(key: key);

  @override
  _CreateMenuItemState createState() => _CreateMenuItemState();
}

class _CreateMenuItemState extends State<CreateMenuItem> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Agregar platillo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Agrega un platillo",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/empty.png',
                        width: 250,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el nombre';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre del platillo',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa la descripción';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descripción',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: imageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa la imagen (URL)';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Imagen (URL)',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              List newMenu = widget.menu;
                              newMenu.add({
                                'name': nameController.text,
                                'description': descriptionController.text,
                                'image': imageController.text
                              });

                              FirebaseFirestore.instance
                                  .collection('restaurants')
                                  .doc(Provider.of<UserProvider>(context,
                                          listen: false)
                                      .email)
                                  .update({'menu': newMenu});
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Agregar platillo",
                              style: TextStyle(
                                color: Colors.white,
                              )))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
