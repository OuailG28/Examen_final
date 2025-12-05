<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medicament.dart';
import '../data/medicaments_data.dart';

class MedicamentService extends ChangeNotifier {
  List<int> _favoriteIds = [];
  List<String> _searchHistory = [];

  List<int> get favoriteIds => _favoriteIds;
  List<String> get searchHistory => _searchHistory;

  MedicamentService() {
    _loadFavorites();
    _loadSearchHistory();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_medications') ?? [];
    _favoriteIds = favorites.map((id) => int.parse(id)).toList();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = _favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('favorite_medications', favorites);
  }


  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('search_history') ?? [];
    notifyListeners();
  }

  
  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory);
  }

 
  Future<void> toggleFavorite(int medicamentId) async {
    if (_favoriteIds.contains(medicamentId)) {
      _favoriteIds.remove(medicamentId);
    } else {
      _favoriteIds.add(medicamentId);
    }
    await _saveFavorites();
    notifyListeners();
  }

 
  bool isFavorite(int medicamentId) {
    return _favoriteIds.contains(medicamentId);
  }


  List<Medicament> getFavoriteMedicaments() {
    return getAllMedicaments()
        .where((med) => _favoriteIds.contains(med.id))
        .toList();
  }


  Future<void> addToSearchHistory(String query) async {
    if (query.trim().isEmpty) return;

    _searchHistory.remove(query);
    _searchHistory.insert(0, query);

    if (_searchHistory.length > 10) {
      _searchHistory = _searchHistory.sublist(0, 10);
    }

    await _saveSearchHistory();
    notifyListeners();
  }


  Future<void> removeFromSearchHistory(String query) async {
    _searchHistory.remove(query);
    await _saveSearchHistory();
    notifyListeners();
  }


  Future<void> clearSearchHistory() async {
    _searchHistory.clear();
    await _saveSearchHistory();
    notifyListeners();
  }

  List<Medicament> getAllMedicaments() {
    return medicamentsData.map((data) => Medicament.fromJson(data)).toList();
  }

  List<Medicament> searchMedicaments(String query) {
    if (query.isEmpty) return getAllMedicaments();

    final lowerQuery = query.toLowerCase();
    return getAllMedicaments().where((med) {
      return med.nom.toLowerCase().contains(lowerQuery) ||
          med.type.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Medicament> filterByType(String type) {
    if (type.isEmpty || type == 'Tous') return getAllMedicaments();
    return getAllMedicaments()
        .where((med) => med.type.toLowerCase() == type.toLowerCase())
        .toList();
  }


  List<String> getAvailableTypes() {
    final types = getAllMedicaments().map((med) => med.type).toSet().toList();
    types.sort();
    return ['Tous', ...types];
  }
}
=======
import '../models/medicament.dart';
import '../data/medicaments_data.dart';

class MedicamentService {
  List<Medicament> getAllMedicaments() {
    return medicamentsData.map((data) => Medicament.fromJson(data)).toList();
  }

  List<Medicament> searchMedicaments(String query) {
    if (query.isEmpty) return getAllMedicaments();

    final lowerQuery = query.toLowerCase();
    return getAllMedicaments().where((med) {
      return med.nom.toLowerCase().contains(lowerQuery) ||
          med.type.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
>>>>>>> 538c791 (finalisation de l'app par ouail)
