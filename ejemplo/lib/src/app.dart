import 'package:flutter/material.dart';

class App_Login extends StatefulWidget {
  const App_Login({super.key});

  @override
  State<App_Login> createState() => _App_LoginState();
}

class _App_LoginState extends State<App_Login> {
  // Controladores para campos de texto
  final TextEditingController ciController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController edadController = TextEditingController();

  // Género (Radio buttons)
  String genero = 'Masculino';

  // Estado civil (Checkboxes)
  bool esSoltero = false;
  bool esCasado = false;

  // Funciones básicas para botones
  void agregar() {
    // Aquí puedes agregar lógica para insertar los datos
    print('Agregar: ${ciController.text}, ${nombreController.text}');
  }

  void eliminar() {
    // Limpia todos los campos
    ciController.clear();
    nombreController.clear();
    apellidoController.clear();
    edadController.clear();
    setState(() {
      genero = 'Masculino';
      esSoltero = false;
      esCasado = false;
    });
  }

  void modificar() {
    // Aquí podrías cargar datos en los campos desde algún origen
    print('Modificar (simulado)');
  }

  void grabar() {
    // Simulación de guardado
    print('Datos guardados');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 117, 117),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 30),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage("images/diddy.jpg"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: ciController,
            decoration: const InputDecoration(labelText: 'Cédula'),
          ),
          TextField(
            controller: nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: apellidoController,
            decoration: const InputDecoration(labelText: 'Apellido'),
          ),
          TextField(
            controller: edadController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Edad'),
          ),
          const SizedBox(height: 20),
          const Text('Género:', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Masculino'),
                  value: 'Masculino',
                  groupValue: genero,
                  onChanged: (value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Femenino'),
                  value: 'Femenino',
                  groupValue: genero,
                  onChanged: (value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const Text('Estado Civil:', style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(
            title: const Text('Soltero/a'),
            value: esSoltero,
            onChanged: (value) {
              setState(() {
                esSoltero = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Casado/a'),
            value: esCasado,
            onChanged: (value) {
              setState(() {
                esCasado = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: agregar,
                child: const Text('Agregar'),
              ),
              ElevatedButton(
                onPressed: eliminar,
                child: const Text('Eliminar'),
              ),
              ElevatedButton(
                onPressed: modificar,
                child: const Text('Modificar'),
              ),
              ElevatedButton(
                onPressed: grabar,
                child: const Text('Grabar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}