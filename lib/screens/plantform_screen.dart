import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/plant_provider.dart';
import 'package:account/models/plants.dart';

class PlantFormScreen extends StatefulWidget {
  final Plant? plant;

  const PlantFormScreen({this.plant, super.key});

  @override
  _PlantFormScreenState createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final scientificNameController = TextEditingController();
  final typeController = TextEditingController();
  final habitatController = TextEditingController();
  final shapeController = TextEditingController();
  final flowerSizeController = TextEditingController();
  final flowerColorController = TextEditingController();

  bool hasFlowers = false;

  @override
  void initState() {
    super.initState();
    if (widget.plant != null) {
      nameController.text = widget.plant!.name;
      scientificNameController.text = widget.plant!.scientificName;
      typeController.text = widget.plant!.type;
      habitatController.text = widget.plant!.habitat;
      shapeController.text = widget.plant!.shape;
      hasFlowers = widget.plant!.hasFlowers;
      if (hasFlowers) {
        flowerSizeController.text = widget.plant!.flowerSize?.toString() ?? '';
        flowerColorController.text = widget.plant!.flowerColor ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มต้นไม้'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อต้นไม้'),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อต้นไม้';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อทางวิทยาศาสตร์'),
                controller: scientificNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อทางวิทยาศาสตร์';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ประเภทต้นไม้'),
                controller: typeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกประเภทต้นไม้';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ถิ่นกำเนิด'),
                controller: habitatController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกถิ่นกำเนิด';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'รูปทรงของต้นไม้'),
                controller: shapeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกรูปทรงของต้นไม้';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('ดอก'),
                value: hasFlowers,
                onChanged: (value) {
                  setState(() {
                    hasFlowers = value;
                  });
                },
              ),
              if (hasFlowers) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ขนาดของดอก'),
                  controller: flowerSizeController,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'สีของดอก'),
                  controller: flowerColorController,
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final plant = Plant(
                      id: widget.plant?.id,
                      name: nameController.text,
                      scientificName: scientificNameController.text,
                      type: typeController.text,
                      habitat: habitatController.text,
                      shape: shapeController.text,
                      hasFlowers: hasFlowers,
                      flowerSize: hasFlowers ? double.tryParse(flowerSizeController.text) : null,
                      flowerColor: hasFlowers ? flowerColorController.text : null,
                    );

                    final provider = Provider.of<PlantProvider>(context, listen: false);
                    if (widget.plant == null) {
                      provider.addPlant(plant);
                    } else {
                      provider.updatePlant(plant);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.plant == null ? 'เพิ่มต้นไม้' : 'อัปเดตต้นไม้'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
