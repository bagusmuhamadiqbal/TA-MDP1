import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/screens/team.dart';
import 'dart:convert';
import 'dart:async';
import 'package:tugas_akhir/screens/team.dart';
import 'package:tugas_akhir/screens/dashboard.dart';

class DetailTeam extends StatefulWidget {
  final int id;
  const DetailTeam({Key? key, required this.id}) : super(key: key);

  @override
  _DetailTeamState createState() => _DetailTeamState();
}

class _DetailTeamState extends State<DetailTeam> {
  late Future<Team> futureTeam;

  @override
  void initState() {
    super.initState();
    futureTeam = fetchTeam(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Team'),
          backgroundColor: Colors.lightBlue[900]),
      backgroundColor: Colors.grey[400],
      body: FutureBuilder(
        future: futureTeam,
        builder: (context, AsyncSnapshot<Team> snapshot) {
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
                const SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(color: Colors.black),
                ),
                Card(
                  color: Colors.blueGrey[400],
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 75.0),
                  child: ListTile(
                    leading: const Text(
                      "DIVISI: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(snapshot.data!.divisi),
                  ),
                ),
                Card(
                    color: Colors.blueGrey[400],
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 75.0),
                    child: ListTile(
                      leading: const Text(
                        "ABOUT US: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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

Future<Team> fetchTeam(id) async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/bagusmuhamadiqbal/TA-MDP1/team/$id/'));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print(response.body);

    return Team.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load episodes');
  }
}
