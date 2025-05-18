import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Usuario',
      home: const FormularioPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();

  String? _genero;
  Map<String, bool> estadoCivil = {
    'Soltero/a': false,
    'Casado/a': false,
    'Divorciado/a': false,
    'Viudo/a': false,
  };

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _fechaNacimientoController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _validarYEnviar() {
    if (_formKey.currentState!.validate()) {
      if (_genero == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Seleccione un género")),
        );
        return;
      }

      if (!estadoCivil.containsValue(true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Seleccione al menos un estado civil")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Formulario enviado con éxito")),
      );
    }
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _edadController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_cedulaController, 'Cédula', TextInputType.number),
              _buildTextField(_nombresController, 'Nombres'),
              _buildTextField(_apellidosController, 'Apellidos'),
              _buildTextField(_edadController, 'Edad', TextInputType.number),

              TextFormField(
                controller: _fechaNacimientoController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Fecha de nacimiento'),
                onTap: () => _seleccionarFecha(context),
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),

              const Align(alignment: Alignment.centerLeft, child: Text('Género')),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Masculino'),
                      value: 'Masculino',
                      groupValue: _genero,
                      onChanged: (value) => setState(() => _genero = value),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Femenino'),
                      value: 'Femenino',
                      groupValue: _genero,
                      onChanged: (value) => setState(() => _genero = value),
                    ),
                  ),
                ],
              ),

              const Align(alignment: Alignment.centerLeft, child: Text('Estado civil')),
              Column(
                children: estadoCivil.entries.map((entry) {
                  return CheckboxListTile(
                    title: Text(entry.key),
                    value: entry.value,
                    onChanged: (bool? newValue) {
                      setState(() {
                        estadoCivil[entry.key] = newValue ?? false;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _validarYEnviar,
                      child: const Text('Siguiente'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Salir'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
