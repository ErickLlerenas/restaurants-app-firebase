import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/home.dart';
import 'package:restaurants/providers/user/provider.dart';
import 'package:restaurants/screens/Login/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Iniciar Sesión",
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
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu correo';
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu contraseña';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                      ),
                    ),
                    SizedBox(height: 20),
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

                                DocumentSnapshot user = await FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(emailController.text.toString().trim())
                                    .get();
                                var data;
                                if (user.exists) data = user.data();

                                if (passwordController.text ==
                                    data['password']) {
                                  await context
                                      .read<UserProvider>()
                                      .writeUserEmail(emailController.text);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Home()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Usuario incorrecto')),
                                  );
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Text("Iniciar Sesión",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                    SizedBox(height: 50),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Register()));
                        },
                        child: Text(
                          "¿No tienes cuenta?",
                          style: TextStyle(
                            color: Colors.purple[800],
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
