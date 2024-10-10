import 'package:flutter/foundation.dart';
import 'package:account/models/plants.dart';
import 'package:account/databases/plant_db.dart';

class PlantProvider with ChangeNotifier {
  List<Plant> plants = [];
  List<Plant> filteredPlants = [];

  List<Plant> getPlants() {
    return filteredPlants.isNotEmpty ? filteredPlants : plants;
  }

  Future<void> initData() async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      plants = await db.loadAllPlants();
      notifyListeners();
    } catch (e) {
      print("Error loading plants: $e");
    }
  }

  Future<void> addPlant(Plant plant) async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      await db.insertPlant(plant);
      await initData(); // Refresh data
      notifyListeners(); // Notify listeners after adding
    } catch (e) {
      print("Error adding plant: $e");
    }
  }

  Future<void> deletePlant(int? id) async {
  if (id == null) return; // Prevent null id from causing issues
  try {
    var db = PlantDB(dbName: 'plants.db');
    await db.deletePlant(id);
    await initData(); // Refresh data
    notifyListeners(); // Notify listeners after deletion
  } catch (e) {
    print("Error deleting plant: $e");
  }
}


  Future<void> updatePlant(Plant plant) async {
    try {
      var db = PlantDB(dbName: 'plants.db');
      await db.updatePlant(plant);
      await initData(); // Refresh data
    } catch (e) {
      print("Error updating plant: $e");
    }
  }

  void searchPlants(String query) {
    if (query.isEmpty) {
      filteredPlants = plants; // ถ้าไม่มีการค้นหาให้แสดงทั้งหมด
    } else {
      filteredPlants = plants.where((plant) {
        return plant.name.toLowerCase().contains(query.toLowerCase()) ||
               plant.scientificName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
