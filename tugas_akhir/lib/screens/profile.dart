import 'package:flutter/material.dart';
import 'package:tugas_akhir/screens/home.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> avatar = <String>['game/profile.jpg'];
  final List<String> nama = <String>['Bagus Muhamad Iqbal'];
  final List<String> nim = <String>['21120119120013'];
  final List<String> email = <String>['iqballfriendly@gmail.com'];

  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      body: Center(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: nama.length, // the length
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 220,
                      height: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          avatar[index],
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
                        nama[index],
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const Text(
                      'Kelompok 21',
                      style: TextStyle(fontSize: 15, color: Colors.black),
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
                        leading: Icon(
                          Icons.badge,
                          color: Colors.blueGrey[100],
                        ),
                        title: Text(nim[index]),
                      ),
                    ),
                    Card(
                        color: Colors.blueGrey[400],
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 75.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.blueGrey[100],
                          ),
                          title: Text(email[index]),
                        )),
                  ],
                );
              })),
    );
  }
}
