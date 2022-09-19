import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.orange,
      title: 'Flutter Demo',
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
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/Home');
                },
                trailing: const Icon(Icons.home),
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, '/Home');
                },
                trailing: const Icon(Icons.settings),
              ),
              ListTile(
                title: const Text('Iniciar Sesion'),
                onTap: () {
                  Navigator.pushNamed(context, '/Login');
                },
                trailing: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('HOME'),
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
        body: const Center(
            child: Text(
          'Este sera la pantalla de inicio',
          style: TextStyle(fontSize: 30.0),
        )),
      ),
    );
  }
}

/*class CostomListTile extends StatelessWidget {
  const CostomListTile({super.key});

  /*IconData icon;
  String text;
  Function onTap;
  CostomListTile(this.icon, this.text, this.onTap);
*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: Colors.orangeAccent,
        onTap: () => {},
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: const [
                  Icon(Icons.home),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/