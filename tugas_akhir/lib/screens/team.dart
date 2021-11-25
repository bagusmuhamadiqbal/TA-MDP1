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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Team>> snapshot) {
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
                              builder: (context) => DetailTeam(
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
          future: fetchTeam(),
        ),
      ),
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
