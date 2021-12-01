import 'package:flutter/material.dart';
import 'package:restaurants/screens/Admin/admin_home_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Administrador",
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
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa la contraseña';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                  SizedBox(height: 30),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text.toLowerCase() ==
                              "admin") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AdminHomeScreen()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Contraseña incorrecta')),
                            );
                          }
                        }
                      },
                      child: Text("Administrar",
                          style: TextStyle(
                            color: Colors.white,
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
