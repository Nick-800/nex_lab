import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Monther');
  final TextEditingController _emailController =
      TextEditingController(text: 'monther69@example.com');
  final TextEditingController _heightController =
      TextEditingController(text: '180 cm');
  final TextEditingController _weightController =
      TextEditingController(text: '75 kg');
  final TextEditingController _bloodTypeController =
      TextEditingController(text: 'O+');

  bool _showHealthDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.health_and_safety),
                title: const Text('Health Details'),
                trailing: Icon(
                    _showHealthDetails ? Icons.expand_less : Icons.expand_more),
                onTap: () {
                  setState(() {
                    _showHealthDetails = !_showHealthDetails;
                  });
                },
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showHealthDetails
                    ? _buildHealthDetails()
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully!')));
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'height': _heightController.text,
                    'weight': _weightController.text,
                    'bloodType': _bloodTypeController.text,
                  });
                },
                child: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthDetails() {
    return Column(
      key: const ValueKey('healthDetails'),
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bloodTypeController,
                decoration: const InputDecoration(
                  labelText: 'Blood Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
