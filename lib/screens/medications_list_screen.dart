import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/medicament_service.dart';
import '../models/medicament.dart';
import 'medication_detail_screen.dart';

class MedicationsListScreen extends StatefulWidget {
  const MedicationsListScreen({super.key});

  @override
  State<MedicationsListScreen> createState() => _MedicationsListScreenState();
}

class _MedicationsListScreenState extends State<MedicationsListScreen> {
  String _selectedFilter = 'Tous';
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final medicamentService = context.watch<MedicamentService>();

    List<Medicament> medicaments;

    if (_showFavoritesOnly) {
      medicaments = medicamentService.getFavoriteMedicaments();
    } else if (_selectedFilter == 'Tous') {
      medicaments = medicamentService.getAllMedicaments();
    } else {
      medicaments = medicamentService.filterByType(_selectedFilter);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Medication',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : Colors.grey.shade700,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            tooltip: _showFavoritesOnly ? 'Tous' : 'Favoris',
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            
            if (!_showFavoritesOnly)
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medicamentService.getAvailableTypes().length,
                  itemBuilder: (context, index) {
                    final type = medicamentService.getAvailableTypes()[index];
                    final isSelected = _selectedFilter == type;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = type;
                          });
                        },
                        backgroundColor: Colors.grey.shade100,
                        selectedColor: Colors.green.shade100,
                        checkmarkColor: Colors.green.shade700,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.green.shade700
                              : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),

           
            Expanded(
              child: medicaments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _showFavoritesOnly
                                ? Icons.favorite_border
                                : Icons.medication_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _showFavoritesOnly
                                ? 'Aucun favori'
                                : 'Aucun médicament',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          if (_showFavoritesOnly)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Ajoutez des médicaments à vos favoris',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: medicaments.length,
                      itemBuilder: (context, index) {
                        final medicament = medicaments[index];
                        final isFavorite = medicamentService.isFavorite(
                          medicament.id,
                        );

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicationDetailScreen(
                                  medicament: medicament,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.medication,
                                    color: Colors.orange.shade600,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        medicament.nom,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        medicament.type,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        ' pharmacie(s)',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    medicamentService.toggleFavorite(
                                      medicament.id,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
