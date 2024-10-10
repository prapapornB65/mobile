import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:account/provider/plant_provider.dart';
import 'package:account/screens/plantform_screen.dart';
import 'package:account/screens/plantdetail_screen.dart';

class PlantHomeScreen extends StatelessWidget {
  const PlantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'ค้นหาต้นไม้...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                final provider =
                    Provider.of<PlantProvider>(context, listen: false);
                provider.searchPlants(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<PlantProvider>(
              builder: (context, provider, child) {
                if (provider.getPlants().isEmpty) {
                  return const Center(child: Text('ไม่มีต้นไม้ในระบบ'));
                } else {
                  return ListView.builder(
                    itemCount: provider.getPlants().length,
                    itemBuilder: (context, index) {
                      var plant = provider.getPlants()[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: ListTile(
                          title: Text(plant.name),
                          subtitle: Text(plant.scientificName),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('ยืนยันการลบ'),
                                    content: const Text(
                                        'คุณต้องการลบต้นไม้นี้หรือไม่?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('ยกเลิก'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider.deletePlant(plant.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('ลบ'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlantDetailScreen(plant: plant),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlantFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
