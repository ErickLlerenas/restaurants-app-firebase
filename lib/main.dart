import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/home.dart';
import 'package:restaurants/providers/user/provider.dart';
import 'package:restaurants/screens/Login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .readUserEmail()
        .then((email) {
      if (email.isNotEmpty) {
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante Chido',
      home: isLoading
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : isLoggedIn
              ? Home()
              : Login(),
    );
  }
}
