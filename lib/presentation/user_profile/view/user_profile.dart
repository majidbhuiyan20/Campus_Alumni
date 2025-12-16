import 'package:flutter/material.dart';

class UserProfileForm extends StatefulWidget {
  final String initialName;
  final String? initialUniversity;
  final String? initialDepartment;
  final String? initialSession;
  final String? initialCurrentPosition;

  const UserProfileForm({
    Key? key,
    required this.initialName,
    this.initialUniversity,
    this.initialDepartment,
    this.initialSession,
    this.initialCurrentPosition,
  }) : super(key: key);

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _universityController;
  late TextEditingController _departmentController;
  late TextEditingController _sessionController;
  late TextEditingController _positionController;

  final _formKey = GlobalKey<FormState>();
  bool _isNameEditable = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _universityController = TextEditingController(text: widget.initialUniversity ?? '');
    _departmentController = TextEditingController(text: widget.initialDepartment ?? '');
    _sessionController = TextEditingController(text: widget.initialSession ?? '');
    _positionController = TextEditingController(text: widget.initialCurrentPosition ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _departmentController.dispose();
    _sessionController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save the profile data
      final profileData = {
        'name': _nameController.text,
        'university': _universityController.text,
        'department': _departmentController.text,
        'session': _sessionController.text,
        'currentPosition': _positionController.text,
      };

      // You can handle the saved data here (save to database, API, etc.)
      print('Profile saved: $profileData');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field with Google sign-in note
              _buildNameField(),

              const SizedBox(height: 25),

              // University Field
              _buildTextField(
                controller: _universityController,
                label: 'University Name',
                hintText: 'Enter your university name',
                icon: Icons.school,
              ),

              const SizedBox(height: 20),

              // Department Field
              _buildTextField(
                controller: _departmentController,
                label: 'Department',
                hintText: 'Enter your department',
                icon: Icons.business,
              ),

              const SizedBox(height: 20),

              // Session Field
              _buildTextField(
                controller: _sessionController,
                label: 'Session',
                hintText: 'e.g., 2020-2024',
                icon: Icons.date_range,
                keyboardType: TextInputType.datetime,
              ),

              const SizedBox(height: 20),

              // Current Position Field
              _buildTextField(
                controller: _positionController,
                label: 'Current Position',
                hintText: 'Enter your current position/job title',
                icon: Icons.work,
              ),

              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Preview Section
              _buildProfilePreview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'From Google',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _nameController,
                enabled: _isNameEditable,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person, color: Colors.blue),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNameEditable ? Icons.lock_open : Icons.lock,
                      color: _isNameEditable ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNameEditable = !_isNameEditable;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: _isNameEditable ? Colors.white : Colors.grey[50],
                ),
                style: TextStyle(
                  color: _isNameEditable ? Colors.black : Colors.grey[700],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _isNameEditable
              ? 'Name is editable. You can change it from the Google value.'
              : 'Name is locked. Tap the lock icon to edit.',
          style: TextStyle(
            fontSize: 12,
            color: _isNameEditable ? Colors.green[700] : Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: Colors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: keyboardType,
          validator: (value) {
            if (label == 'University Name' && (value == null || value.isEmpty)) {
              return 'Please enter your university name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildProfilePreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 12),
          _buildPreviewItem('Name:', _nameController.text),
          _buildPreviewItem('University:', _universityController.text),
          _buildPreviewItem('Department:', _departmentController.text),
          _buildPreviewItem('Session:', _sessionController.text),
          _buildPreviewItem('Current Position:', _positionController.text),
        ],
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not provided' : value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: value.isEmpty ? Colors.grey[400] : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage in a main.dart file
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example: User signed in with Google with name "John Doe"
    return UserProfileForm(
      initialName: 'John Doe',
      initialUniversity: 'Stanford University',
      initialDepartment: 'Computer Science',
      initialSession: '2020-2024',
      initialCurrentPosition: 'Software Engineer',
    );
  }
}
*/