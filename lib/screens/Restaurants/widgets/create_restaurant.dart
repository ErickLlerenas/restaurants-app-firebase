import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/providers/user/provider.dart';

class CreateRestaurant extends StatefulWidget {
  const CreateRestaurant({Key? key}) : super(key: key);

  @override
  _CreateRestaurantState createState() => _CreateRestaurantState();
}

class _CreateRestaurantState extends State<CreateRestaurant> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Crea un nuevo restaurante",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        "assets/empty.png",
                        width: 250,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el nombre';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: locationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa la dirección';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Dirección',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: rfcController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el RFC';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'RFC',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: typeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el tipo';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tipo de restaurante',
                        ),
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.amber)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  CollectionReference restaurants =
                                      FirebaseFirestore.instance
                                          .collection('restaurants');

                                  await restaurants
                                      .doc(Provider.of<UserProvider>(context,
                                              listen: false)
                                          .email)
                                      .set({
                                    'name': nameController.text,
                                    'location': locationController.text,
                                    'RFC': rfcController.text,
                                    'type': typeController.text,
                                    'menu': [],
                                    'isAccepted': false,
                                    'id': Provider.of<UserProvider>(context,
                                            listen: false)
                                        .email
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Restaurante creado con éxito')),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Crear",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
