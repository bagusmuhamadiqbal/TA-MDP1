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
      backgroundColor: Colors.brown,
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Game>> snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.brown[300],
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(snapshot.data![index].gambar),
                          backgroundColor: Colors.brown[100],
                        ),
                        title: Text(snapshot.data![index].nama),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailGame(
                                id: snapshot.data![index].id,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            return const CircularProgressIndicator();
          },
          future: fetchGame(),
        ),
      ),
    );
  }
}

