<<<<<<< HEAD
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
=======
import 'pharmacie.dart';

class Medicament {
  final int id;
  final String nom;
  final String type;
  final List<Pharmacie> pharmacies;

  Medicament({
    required this.id,
    required this.nom,
    required this.type,
    required this.pharmacies,
  });

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json['id'],
      nom: json['nom'],
      type: json['type'],
      pharmacies: (json['pharmacies'] as List)
          .map((p) => Pharmacie.fromJson(p))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'type': type,
      'pharmacies': pharmacies.map((p) => p.toJson()).toList(),
    };
  }
}
>>>>>>> 538c791 (finalisation de l'app par ouail)
