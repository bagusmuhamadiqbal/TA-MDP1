import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:tugas_akhir/screens/game.dart';
import 'package:tugas_akhir/screens/detail_game.dart';

/// This is the main application widget.
Future<List<Game>> fetchGame() async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/bagusmuhamadiqbal/TA-MDP1/game'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return parseGame(response.body);
}

// A function that converts a response body into a List<Photo>.
List<Game> parseGame(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Game>((json) => Game.fromJson(json)).toList();
}

/// This is the stateless widget that the main application instantiates.
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Game> futureGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Game>>(
        future: fetchGame(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return GameList(game: snapshot.data!);
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

class GameList extends StatelessWidget {
  const GameList({Key? key, required this.game}) : super(key: key);

  final List<Game> game;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: game.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailGame(
                            id: game[index].id,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  game[index].gambar,
                  scale: 2.5,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Text(
                  game[index].nama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
