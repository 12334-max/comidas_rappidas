import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.orange,
      title: 'Rappi',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Login');
                  },
                  icon: const Icon(Icons.account_circle),
                  iconSize: 100.0,
                ),
              ),
              ListTile(
                title: const Text('Platillos'),
                onTap: () {
                  Navigator.pushNamed(context, '/Home');
                },
                trailing: const Icon(Icons.home),
              ),
              ListTile(
                title: const Text('Cerra Sesion'),
                onTap: () {
                  Navigator.of(context).pushNamed('/Login');
                },
                trailing: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('RAPPI 2'),
          actions: <Widget>[
            IconButton(
              splashColor: Colors.blueGrey,
              onPressed: () {
                Navigator.pushNamed(context, '/Login');
              },
              icon: const Icon(
                Icons.account_circle_rounded,
                size: 40.0,
              ),
              padding: const EdgeInsets.only(right: 30.0),
            )
          ],
        ),
        body: const Center(),
        bottomNavigationBar: BottomNavigationBar(
          
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.adb_sharp), label: 'Pendientes')
          ],
        ),
      ),
    );
  }
}
