import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyController;
  late TextEditingController _vatController;
  late TextEditingController _addressController;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
    _companyController = TextEditingController(text: profile.company);
    _vatController = TextEditingController(text: profile.vatNumber);
    _addressController = TextEditingController(text: profile.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _vatController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<ProfileProvider>().update(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          company: _companyController.text.trim(),
          vatNumber: _vatController.text.trim(),
          address: _addressController.text.trim(),
        );
    if (mounted) {
      setState(() => _editing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profilo salvato')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo'),
        actions: [
          if (_editing)
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: 'Salva',
              onPressed: _save,
            )
          else
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Modifica',
              onPressed: () => setState(() => _editing = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Consumer<ProfileProvider>(
                    builder: (context, profile, _) {
                      final initials = profile.name.isNotEmpty
                          ? profile.name
                              .trim()
                              .split(' ')
                              .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
                              .take(2)
                              .join()
                          : '?';
                      return Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _buildField(
                controller: _nameController,
                label: 'Nome e cognome',
                icon: Icons.person_outline,
                enabled: _editing,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                enabled: _editing,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _phoneController,
                label: 'Telefono',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                enabled: _editing,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _companyController,
                label: 'Azienda / Studio',
                icon: Icons.business_outlined,
                enabled: _editing,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _vatController,
                label: 'Partita IVA',
                icon: Icons.badge_outlined,
                enabled: _editing,
              ),
              const SizedBox(height: 14),
              _buildField(
                controller: _addressController,
                label: 'Indirizzo',
                icon: Icons.location_on_outlined,
                enabled: _editing,
                maxLines: 2,
              ),
              if (_editing) ...[
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Salva profilo'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.withOpacity(0.08),
      ),
    );
  }
}
