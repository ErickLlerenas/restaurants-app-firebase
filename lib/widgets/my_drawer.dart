import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/providers/user/provider.dart';
import 'package:restaurants/screens/Login/login.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List user = [
    {"name": "", "phone": "", "date": "", "email": ""}
  ];
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<UserProvider>(context, listen: false).email)
        .get()
        .then((userDocument) {
      setState(() {
        user[0] = userDocument.data();
        print(userDocument.data());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    image: AssetImage("assets/icon.png"), fit: BoxFit.cover)),
            child: Text(''),
          ),
          ListTile(
            title: Text(user[0]['name']),
            leading: Icon(Icons.person_outlined),
          ),
          ListTile(
            title: Text(user[0]['phone']),
            leading: Icon(Icons.phone_outlined),
          ),
          ListTile(
            title: Text(user[0]['email']),
            leading: Icon(Icons.mail_outline),
          ),
          ListTile(
            title: Text(user[0]['date']),
            leading: Icon(Icons.calendar_today_outlined),
          ),
          ListTile(
            trailing: Icon(Icons.navigate_next),
            title: const Text('Cerrar Sesión'),
            leading: Icon(Icons.logout),
            onTap: () async {
              Navigator.pop(context);

              await context.read<UserProvider>().writeUserEmail('');
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Login()));
            },
          )
        ],
      ),
    );
  }
}
