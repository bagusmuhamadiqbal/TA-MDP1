import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:tugas_akhir/screens/detail_team.dart';

Future<List<Team>> fetchTeam() async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/bagusmuhamadiqbal/TA-MDP1/team'));

  return parseTeam(response.body);
}

List<Team> parseTeam(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Team>((json) => Team.fromJson(json)).toList();
}

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late Future<Team> futureTeam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Team>>(
          future: fetchTeam(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return TeamList(team: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TeamList extends StatelessWidget {
  const TeamList({Key? key, required this.team}) : super(key: key);

  final List<Team> team;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: team.length,
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
                      builder: (context) => DetailTeam(
                            id: team[index].id,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  team[index].gambar,
                  scale: 2.5,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    team[index].nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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

class Team {
  final int id;
  final String nama;
  final String divisi;
  final String bio;
  final String gambar;

  Team(
      {required this.id,
      required this.nama,
      required this.divisi,
      required this.bio,
      required this.gambar});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
        id: json['id'] as int,
        nama: json['nama'] as String,
        divisi: json['divisi'] as String,
        bio: json['bio'] as String,
        gambar: json['gambar'] as String);
  }
}
