import 'package:flutter/material.dart';

const vehicleBlue = Color(0xFF1769FF);
const vehicleDarkBlue = Color(0xFF10204A);

class VehicleInsuranceScreen extends StatefulWidget {
  const VehicleInsuranceScreen({super.key});

  @override
  State<VehicleInsuranceScreen> createState() => _VehicleInsuranceScreenState();
}

class _VehicleInsuranceScreenState extends State<VehicleInsuranceScreen> {
  final List<Map<String, String>> vehicles = [];

  Future<void> _addVehicle() async {
    final vehicle = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
    );

    if (vehicle != null && mounted) {
      setState(() {
        vehicles.add(vehicle);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vehicle added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Vehicle Insurance',
          style: TextStyle(color: vehicleDarkBlue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: vehicleDarkBlue,
        surfaceTintColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [vehicleBlue, Color(0xFF5795FF)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.directions_car_rounded,
                  size: 42,
                  color: Colors.white,
                ),
                SizedBox(height: 14),
                Text(
                  'Protect your ride',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your vehicles and explore insurance '
                  'options in one place.',
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'My Vehicles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: vehicleDarkBlue,
                  ),
                ),
              ),
              Text('${vehicles.length} added'),
            ],
          ),
          const SizedBox(height: 14),

          if (vehicles.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 60,
                    color: vehicleBlue,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No vehicles added yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: vehicleDarkBlue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your vehicle to start managing '
                    'its insurance details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey, height: 1.5),
                  ),
                ],
              ),
            )
          else
            ...vehicles.asMap().entries.map((entry) {
              final index = entry.key;
              final vehicle = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.directions_car_rounded,
                        color: vehicleBlue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: vehicleDarkBlue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text('Registration: ${vehicle['number']}'),
                          Text('Type: ${vehicle['type']}'),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Remove vehicle',
                      onPressed: () {
                        setState(() {
                          vehicles.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 18),
          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: _addVehicle,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add a Vehicle',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: vehicleBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  String _type = 'Car';

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text('Add a Vehicle'),
        backgroundColor: Colors.white,
        foregroundColor: vehicleDarkBlue,
        surfaceTintColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const Icon(
              Icons.directions_car_filled_rounded,
              size: 66,
              color: vehicleBlue,
            ),
            const SizedBox(height: 12),
            const Text(
              'Vehicle Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: vehicleDarkBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your vehicle information below.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 28),

            const Text(
              'Vehicle Name / Model',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration(
                'e.g. Maruti Swift',
                Icons.directions_car_outlined,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the vehicle name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Registration Number',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _numberController,
              textCapitalization: TextCapitalization.characters,
              decoration: _inputDecoration(
                'e.g. MH12AB1234',
                Icons.confirmation_number_outlined,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the registration number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Vehicle Type',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: _inputDecoration(
                'Select vehicle type',
                Icons.category_outlined,
              ),
              items: const [
                DropdownMenuItem(value: 'Car', child: Text('Car')),
                DropdownMenuItem(value: 'Bike', child: Text('Bike')),
                DropdownMenuItem(value: 'Scooter', child: Text('Scooter')),
                DropdownMenuItem(
                  value: 'Commercial',
                  child: Text('Commercial Vehicle'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _type = value);
                }
              },
            ),
            const SizedBox(height: 30),

            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  Navigator.pop(context, <String, String>{
                    'name': _nameController.text.trim(),
                    'number': _numberController.text.trim().toUpperCase(),
                    'type': _type,
                  });
                },
                style: FilledButton.styleFrom(
                  backgroundColor: vehicleBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Save Vehicle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: vehicleBlue),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE1E7F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: vehicleBlue, width: 1.5),
      ),
    );
  }
}
