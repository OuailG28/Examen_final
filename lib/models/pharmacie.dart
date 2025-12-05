class Pharmacie {
  final String nom;
  final String adresse;
  final String ville;
  final String tel;
  final String horaires;
  final double? latitude;
  final double? longitude;

  Pharmacie({
    required this.nom,
    required this.adresse,
    required this.ville,
    required this.tel,
    required this.horaires,
    this.latitude,
    this.longitude,
  });

  factory Pharmacie.fromJson(Map<String, dynamic> json) {
    return Pharmacie(
      nom: json['nom'],
      adresse: json['adresse'],
      ville: json['ville'],
      tel: json['tel'],
      horaires: json['horaires'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'adresse': adresse,
      'ville': ville,
      'tel': tel,
      'horaires': horaires,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
