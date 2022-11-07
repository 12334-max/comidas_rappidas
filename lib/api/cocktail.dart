import 'package:flutter/material.dart';
import 'package:rappi_2/models/cocktails.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Cocktails> _cocktails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COCKTAILS'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: Cocktails.leeTodos(),
        builder: (context, AsyncSnapshot<List<Cocktails>> snapshot) {
          if (snapshot.hasData) {
            _cocktails = snapshot.data!;
            return _columnaCentral();
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amberAccent),
            );
          }
        },
      ),
    );
  }

  Widget _columnaCentral() {
    return SingleChildScrollView(
        reverse: false,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _listaCocteles(),
          ],
        ));
  }

  Widget _listaCocteles() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Cocktails cocktel = _cocktails[i];
        return ListTile(
          leading: cocktel.url,
          title: Text(cocktel.nombre),
          subtitle: Text("${cocktel.ingredientes} - ${cocktel.instruccion}"),
          trailing: const Icon(Icons.local_drink_sharp),
        );
      },
      itemCount: _cocktails.length,
    );
  }
}
