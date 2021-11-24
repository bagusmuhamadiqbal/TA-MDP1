class Game {
  final int id;
  final String nama;
  final String turnament;
  final String bio;
  final String gambar;

  Game(
      {required this.id,
      required this.nama,
      required this.turnament,
      required this.bio,
      required this.gambar});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        id: json['id'] as int,
        nama: json['nama'] as String,
        turnament: json['turnament'] as String,
        bio: json['bio'] as String,
        gambar: json['gambar'] as String);
  }
}
