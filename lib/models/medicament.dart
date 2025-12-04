class Medicament {
  final int id;
  final String nom;
  final String type;

  Medicament({required this.id, required this.nom, required this.type});

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(id: json['id'], nom: json['nom'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nom': nom, 'type': type};
  }
}
