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
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                //enzabezado en negritas
                  child: Text(
                'Encabezado',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              CostomListTile()
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
              icon: const Icon(Icons.login),
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

class CostomListTile extends StatelessWidget {
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
