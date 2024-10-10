import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/plants.dart';


class PlantDB {
  final String dbName;
  Database? _db;

  PlantDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    return await dbFactory.openDatabase(dbLocation);
  }

  Future<Database> get database async {
    _db ??= await openDatabase();
    return _db!;
  }

  Future<int> insertPlant(Plant plant) async {
    try {
      var db = await database;
      var store = intMapStoreFactory.store('plants');
      var id = await store.add(db, {
        "name": plant.name,
        "scientificName": plant.scientificName,
        "type": plant.type,
        "habitat": plant.habitat,
        "shape": plant.shape,
        "hasFlowers": plant.hasFlowers,
        "flowerSize": plant.flowerSize,
        "flowerColor": plant.flowerColor,
      });
      return id;
    } catch (e) {
      throw Exception("Error inserting plant: $e");
    }
  }

  Future<List<Plant>> loadAllPlants() async {
    try {
      var db = await database;
      var store = intMapStoreFactory.store('plants');
      var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
      return snapshot.map((record) {
        return Plant(
          id: record.key,
          name: record['name'].toString(),
          scientificName: record['scientificName'].toString(),
          type: record['type'].toString(),
          habitat: record['habitat'].toString(),
          shape: record['shape'].toString(),
          hasFlowers: record['hasFlowers'] as bool,
          flowerSize: record['flowerSize'] != null ? (record['flowerSize'] as num).toDouble() : null,
          flowerColor: record['flowerColor']?.toString(),
        );
      }).toList();
    } catch (e) {
      throw Exception("Error loading plants: $e");
    }
  }

  Future<void> updatePlant(Plant plant) async {
    if (plant.id == null) {
      throw Exception("Plant ID cannot be null for update.");
    }
    try {
      var db = await database;
      var store = intMapStoreFactory.store('plants');
      await store.record(plant.id!).update(db, {
        "name": plant.name,
        "scientificName": plant.scientificName,
        "type": plant.type,
        "habitat": plant.habitat,
        "shape": plant.shape,
        "hasFlowers": plant.hasFlowers,
        "flowerSize": plant.flowerSize,
        "flowerColor": plant.flowerColor,
      });
    } catch (e) {
      throw Exception("Error updating plant: $e");
    }
  }

  Future<void> deletePlant(int? id) async {
    try {
      var db = await database;
      var store = intMapStoreFactory.store('plants');
      await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, id)));
    } catch (e) {
      throw Exception("Error deleting plant: $e");
    }
  }
}
