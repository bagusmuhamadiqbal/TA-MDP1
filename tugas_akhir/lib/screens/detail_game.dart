import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:tugas_akhir/screens/game.dart';
import 'package:tugas_akhir/screens/dashboard.dart';

class DetailGame extends StatefulWidget {
  final int id;
  const DetailGame({Key? key, required this.id}) : super(key: key);

  @override
  _DetailGameState createState() => _DetailGameState();
}

class _DetailGameState extends State<DetailGame> {
  late Future<Game> futureGame;

  @override
  void initState() {
    super.initState();
    futureGame = fetchGame(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Game'), backgroundColor: Colors.brown[900]),
      backgroundColor: Colors.brown,
      body: FutureBuilder(
        future: futureGame,
        builder: (context, AsyncSnapshot<Game> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 220,
                  height: 250,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(
                      snapshot.data!.gambar,
                      fit: BoxFit.cover,
                    ),
                    elevation: 55,
                    margin: const EdgeInsets.only(
                        top: 60, bottom: 20, left: 20, right: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    snapshot.data!.nama,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const Text(
                  'GAMES',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(color: Colors.black),
                ),
                Card(
                  color: Colors.brown[300],
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 75.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.view_agenda,
                      color: Colors.white70,
                    ),
                    title: Text(snapshot.data!.turnament),
                  ),
                ),
                Card(
                    color: Colors.brown[300],
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 75.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.biotech,
                        color: Colors.white70,
                      ),
                      title: Text(snapshot.data!.bio),
                    )),
              ],
            ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<Game> fetchGame(id) async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/bagusmuhamadiqbal/TA-MDP1/game/$id/'));
  if (response.statusCode == 200) {
    print(response.body);

    return Game.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load episodes');
  }
}

